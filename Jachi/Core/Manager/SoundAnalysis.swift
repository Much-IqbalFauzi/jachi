//
//  SoundAnalysis.swift
//  Jachi
//
//  Created by Muchamad Iqbal Fauzi on 19/06/25.
//

import Combine
import SoundAnalysis

final class SoundAnalysisManager: NSObject {

    // 1.
    private let bufferSize = 8192

    private var audioEngine: AVAudioEngine?
    private var inputBus: AVAudioNodeBus?
    private var inputFormat: AVAudioFormat?
    private var bufferTrack: [AVAudioPCMBuffer] = []
    private var audioURL: URL?

    private var streamAnalyzer: SNAudioStreamAnalyzer?

    private let analysisQueue = DispatchQueue(label: "JaChi.SoundAnalysisQueue")

    private var retainedObserver: SNResultsObserving?
    private var subject: PassthroughSubject<SNClassificationResult, Error>?

    static let shared = SoundAnalysisManager()

    private override init() {}

    private func setupAudioEngine() {
        audioEngine = AVAudioEngine()
        let inputBus = AVAudioNodeBus(0)
        self.inputBus = inputBus
        inputFormat = audioEngine?.inputNode.inputFormat(forBus: inputBus)
    }

    // 3.
    private func startAnalysis(
        _ requestAndObserver: (request: SNRequest, observer: SNResultsObserving)
    ) throws {
        // a.
        setupAudioEngine()

        // b.
        guard let audioEngine = audioEngine,
            let inputBus = inputBus,
            let inputFormat = inputFormat
        else { return }

        // c.
        let streamAnalyzer = SNAudioStreamAnalyzer(format: inputFormat)
        self.streamAnalyzer = streamAnalyzer
        // d.
        try streamAnalyzer.add(
            requestAndObserver.request,
            withObserver: requestAndObserver.observer)
        // e.
        retainedObserver = requestAndObserver.observer

        // f.
        self.audioEngine?.inputNode.installTap(
            onBus: inputBus,
            bufferSize: UInt32(bufferSize),
            format: inputFormat
        ) { buffer, time in
            self.bufferTrack.append(buffer)
            self.analysisQueue.async {
                self.streamAnalyzer?.analyze(
                    buffer, atAudioFramePosition: time.sampleTime)
            }
        }

        do {
            // g.
            try audioEngine.start()
        } catch {
            print(
                "Unable to start AVAudioEngine: \(error.localizedDescription)")
        }
    }

    private func mergeBuffers(_ buffers: [AVAudioPCMBuffer]) -> AVAudioPCMBuffer
    {
        let format = buffers.first!.format
        let totalFrameCount = buffers.reduce(0) { $0 + Int($1.frameLength) }

        guard
            let newBuffer = AVAudioPCMBuffer(
                pcmFormat: format,
                frameCapacity: AVAudioFrameCount(totalFrameCount))
        else {
            fatalError("Could not create buffer")
        }

        for buffer in buffers {
            let dest =
                newBuffer.floatChannelData![0] + Int(newBuffer.frameLength)
            let src = buffer.floatChannelData![0]
            memcpy(
                dest, src, Int(buffer.frameLength) * MemoryLayout<Float>.size)
            newBuffer.frameLength += buffer.frameLength
        }

        return newBuffer
    }
    
    private func saveBufferToFile(buffer: AVAudioPCMBuffer, sampleRate: Double)
        -> URL?
    {
        // Validate buffer
        guard buffer.frameLength > 0 else {
            return nil
        }

        // Create unique filename
        let filename = "recording_\(Date().timeIntervalSince1970).caf"
        let fileURL = FileManager.default.temporaryDirectory.appendingPathComponent(
            filename)

        // Configure audio settings
        let settings: [String: Any] = [
            AVFormatIDKey: kAudioFormatLinearPCM,
            AVSampleRateKey: sampleRate,
            AVNumberOfChannelsKey: buffer.format.channelCount,
            AVLinearPCMBitDepthKey: 32,
            AVLinearPCMIsFloatKey: true,
            AVLinearPCMIsBigEndianKey: false,
        ]

        do {
            let file = try AVAudioFile(forWriting: fileURL, settings: settings)
            try file.write(from: buffer)
            return fileURL
        } catch {
            return nil
        }
    }

    // 4.
    func startSoundClassification(
        subject: PassthroughSubject<SNClassificationResult, Error>,
        inferenceWindowSize: Double? = nil,
        overlapFactor: Double? = nil
    ) {
        do {
            // a.
            let observer = ResultsObserver(subject: subject)

            // b. Request with Sound Analysis' built-in Sound Classifier.
            let classifier = try MySound108(
                configuration: MLModelConfiguration())
            let model = classifier.model
            let request = try SNClassifySoundRequest(mlModel: model)

            // c.
            if let inferenceWindowSize = inferenceWindowSize {
                request.windowDuration = CMTimeMakeWithSeconds(
                    inferenceWindowSize, preferredTimescale: 48_000)
            }
            if let overlapFactor = overlapFactor {
                request.overlapFactor = overlapFactor
            }

            self.subject = subject
            try startAnalysis((request, observer))
        } catch {
            subject.send(completion: .failure(error))
            self.subject = nil
        }
    }

    // 5.
    func stopSoundClassification() {
        // a.
        buildAudioBufferList()
        autoreleasepool {
            // b.
            if let audioEngine = audioEngine {
                audioEngine.stop()
                audioEngine.inputNode.removeTap(onBus: 0)
            }
            // c.
            if let streamAnalyzer = streamAnalyzer {
                streamAnalyzer.removeAllRequests()
            }
            // d.
            streamAnalyzer = nil
            retainedObserver = nil
            audioEngine = nil
        }
        self.bufferTrack = []
    }
    
    // 6.
    private func buildAudioBufferList()  {
        let sampleRate = self.audioEngine!.inputNode.outputFormat(forBus: 0)
            .sampleRate
        let fullBuffer = self.mergeBuffers(bufferTrack)
        //        let fullDuration = Float(fullBuffer.frameLength) / Float(sampleRate)

        if let audioURL = saveBufferToFile(
            buffer: fullBuffer, sampleRate: sampleRate)
        {
//            return audioURL
            self.audioURL = audioURL
        }
    }
    
    func playAudio() {
        // 1. Verify file exists
        
        guard FileManager.default.fileExists(atPath: audioURL?.path() ?? "") else {
            return
        }
        // 2. Configure audio session
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playback, mode: .default)
            try session.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("❌ Audio session setup failed: \(error.localizedDescription)")
            return
        }

        // 3. Initialize player safely
        do {
            let player = try AVAudioPlayer(contentsOf: audioURL!)
            player.prepareToPlay()

            // 4. Store reference and play
            DispatchQueue.main.async {
                player.play()
                print("✅ Playing audio successfully \(self.audioURL?.path() ?? "-")")
            }
        } catch {
            print(
                "❌ Player initialization failed: \(error.localizedDescription)")

            // Debug the problematic file
            if let data = try? Data(contentsOf: audioURL!) {
                print("File size: \(data.count) bytes")
            } else {
                print("Couldn't read file data")
            }
        }
    }
}
