import Foundation
import Speech
import AVFoundation
import SoundAnalysis
import CoreML

class SpeechRecognizer: NSObject, ObservableObject {
    @Published var transcript: String = ""
    @Published var isRecording: Bool = false
    @Published var originalAudioDuration: Float = 0.0
    @Published var splicedAudioDuration: Float = 0.0
    @Published var predictedClass: String = ""
    @Published var resultCode: Int = -1
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "zh-CN"))
    private let audioEngine = AVAudioEngine()
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private var analyzer: SNAudioStreamAnalyzer?
    private var audioBufferList: [AVAudioPCMBuffer] = []
    private var audioDuration: TimeInterval = 0
    private var audioStartTime: Date?
    private var beforeTargetTimeOffset: TimeInterval?
    private var recordingBuffer: AVAudioPCMBuffer?
    private var recordedBuffers: [AVAudioPCMBuffer] = []
    
    
    func requestPermissions() {
        SFSpeechRecognizer.requestAuthorization { status in
            if status != .authorized {
                print("Speech recognition not authorized")
            }
        }
        #if os(iOS)
        AVAudioSession.sharedInstance().requestRecordPermission { allowed in
            if !allowed {
                print("Microphone access denied")
            }
        }
        #endif
    }
    
    
    func startRecordingReal(beforeTarget: String, target: String, duration: Float) {
        transcript = ""
        isRecording = true
        audioStartTime = Date()
        beforeTargetTimeOffset = nil
        recordedBuffers = []
        
        #if os(iOS)
        let audioSession = AVAudioSession.sharedInstance()
        try? audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try? audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        #endif
        
        let inputNode = audioEngine.inputNode
        let format = inputNode.outputFormat(forBus: 0)
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else {
            print("Unable to create request")
            return
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { result, error in
            if let result = result {
                DispatchQueue.main.async {
                    self.transcript = result.bestTranscription.formattedString
                    if self.beforeTargetTimeOffset == nil,
                       self.transcript.contains(beforeTarget),
                       let start = self.audioStartTime {
                        self.beforeTargetTimeOffset = Date().timeIntervalSince(start)
                    }
                }
            }
        }
        
        inputNode.removeTap(onBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: format) { buffer, _ in
            self.recognitionRequest?.append(buffer)
            self.recordedBuffers.append(buffer)
        }
        
        audioEngine.prepare()
        try? audioEngine.start()
    }
    
    
    func stopRecordingReal(target: String, duration: Float) -> Int {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionRequest?.endAudio()
        isRecording = false
        
        guard let beforeOffset = beforeTargetTimeOffset else {
            self.resultCode = 10000
            return 10000
        }
        
        let sampleRate = audioEngine.inputNode.outputFormat(forBus: 0).sampleRate
        let startSample = Int(beforeOffset * sampleRate)
        let endSample = Int((beforeOffset + Double(duration)) * sampleRate)
        
        let fullBuffer = mergeBuffers(recordedBuffers)
        let fullDuration = Float(fullBuffer.frameLength) / Float(sampleRate)
        let slicedBuffer = sliceBuffer(fullBuffer, fromSample: startSample, toSample: endSample)
        let slicedDuration = Float(slicedBuffer.frameLength) / Float(sampleRate)
        
        self.originalAudioDuration = fullDuration
        self.splicedAudioDuration = slicedDuration
        
        let result = classify(buffer: slicedBuffer, target: target)
        return result
    }
    
    
    private func mergeBuffers(_ buffers: [AVAudioPCMBuffer]) -> AVAudioPCMBuffer {
        let format = buffers.first!.format
        let totalFrameCount = buffers.reduce(0) { $0 + Int($1.frameLength) }
        
        guard let newBuffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: AVAudioFrameCount(totalFrameCount)) else {
            fatalError("Could not create buffer")
        }
        
        for buffer in buffers {
            let dest = newBuffer.floatChannelData![0] + Int(newBuffer.frameLength)
            let src = buffer.floatChannelData![0]
            memcpy(dest, src, Int(buffer.frameLength) * MemoryLayout<Float>.size)
            newBuffer.frameLength += buffer.frameLength
        }
        
        return newBuffer
    }
    
    func sliceBuffer(_ buffer: AVAudioPCMBuffer, fromSample: Int, toSample: Int) -> AVAudioPCMBuffer {
        let totalSamples = Int(buffer.frameLength)
        let clampedFrom = max(0, min(fromSample, totalSamples - 1))
        let clampedTo = max(clampedFrom, min(toSample, totalSamples))
        let sliceLength = clampedTo - clampedFrom
        
        guard let format = AVAudioFormat(commonFormat: .pcmFormatFloat32,
                                         sampleRate: buffer.format.sampleRate,
                                         channels: buffer.format.channelCount,
                                         interleaved: false),
              let newBuffer = AVAudioPCMBuffer(pcmFormat: format, frameCapacity: AVAudioFrameCount(sliceLength)) else {
            fatalError("Failed to allocate new buffer")
        }
        
        newBuffer.frameLength = AVAudioFrameCount(sliceLength)
        
        let srcPointer = buffer.floatChannelData![0] + clampedFrom
        let dstPointer = newBuffer.floatChannelData![0]
        
        memcpy(dstPointer, srcPointer, sliceLength * MemoryLayout<Float>.size)
        
        return newBuffer
    }
    
    private func classify(buffer: AVAudioPCMBuffer, target: String) -> Int {
        let format = buffer.format
        let analyzer = SNAudioStreamAnalyzer(format: format)
        
        let semaphore = DispatchSemaphore(value: 0)
        var resultCode = 99999
        var predicted = ""
        
        let request: SNClassifySoundRequest
        do {
            let model = try ModelLongWords(configuration: .init()).model
            request = try SNClassifySoundRequest(mlModel: model)
        } catch {
            print("Model load error: \(error)")
            return 99999
        }
        
        let resultHandler = ClassificationResultHandler(target: target) { result, identifier in
            resultCode = result
            predicted = identifier
            semaphore.signal()
        }
        
        try? analyzer.add(request, withObserver: resultHandler)
        analyzer.analyze(buffer, atAudioFramePosition: 0)
        _ = semaphore.wait(timeout: .now() + 2.0)
        
        self.resultCode = resultCode
        self.predictedClass = predicted
        return resultCode
    }
    
    
    class ClassificationResultHandler: NSObject, SNResultsObserving {
        let target: String
        let callback: (Int, String) -> Void
        
        init(target: String, callback: @escaping (Int, String) -> Void) {
            self.target = target
            self.callback = callback
        }
        
        func request(_ request: SNRequest, didProduce result: SNResult) {
            guard let classificationResult = result as? SNClassificationResult,
                  let mostConfident = classificationResult.classifications.first else {
                callback(15000, "")
                return
            }
            
            let confidenceScore = Int(mostConfident.confidence * 100)
            print("🔍 Comparing predicted: [\(mostConfident.identifier)] vs target: [\(target)]")
            
            if mostConfident.identifier == target {
                if confidenceScore > 50 {
                    callback(confidenceScore, mostConfident.identifier)
                } else {
                    // Correct phrase but low confidence
                    callback(15000, mostConfident.identifier)
                }
            } else {
                // Wrong phrase
                callback(10000, mostConfident.identifier)
            }
        }
        
        func request(_ request: SNRequest, didFailWithError error: Error) {
            print("Classifier error: \(error)")
            callback(99999, "")
        }
        
        func requestDidComplete(_ request: SNRequest) {}
    }
    
}

struct DialogueCardContent: Identifiable {
    let id = UUID()
    var imageName: String
    var progressBarValue: Double
    var textDialogue: String
    var englishTranslation: String?
    
    var isCompleted: Bool {
        progressBarValue >= 1.0
    }
}

let sampleDialogueCards: [DialogueCardContent] = [
    .init(imageName: "Image_Card", progressBarValue: 0.7, textDialogue: "笨蛋", englishTranslation: "Very Smart"),
    .init(imageName: "Image_Card1", progressBarValue: 1.0, textDialogue: "操你吗", englishTranslation: "Thank you"),
    .init(imageName: "Topic Image", progressBarValue: 0.3, textDialogue: "再见", englishTranslation: "Goodbye")
    // Tambah lagi di sini dengan mudah
]

