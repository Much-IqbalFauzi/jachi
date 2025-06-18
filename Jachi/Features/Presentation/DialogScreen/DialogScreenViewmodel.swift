//
//  DialogViewmodel.swift
//  Jachi
//
//  Created by Muchamad Iqbal Fauzi on 12/06/25.
//

import Foundation
import SwiftUI
import AVFoundation
import SoundAnalysis
import CoreML
import Speech

enum auntieState {
    case idle
    case waiting
    case answering
}

enum btnRecordState {
    case record
    case stop
    case submit
    case giveup
}

class DialogViewmodel: NSObject, ObservableObject {
    @Published var title: String = "Dialogue De Umerto"
    
    @Published private(set) var chat: [String] = []
    
    @Published private(set) var chatField: [ConvTalk] = []
    
    private var activeIndex: Int = 0
    private var isAnswerCorrect: Bool = false
    
    private var selectedTopic: ConvTopic
    
    @Published var questionn: ConvTalk = .emptyTalk
    @Published var answer: ConvTalk = .emptyTalk
    
    private var questionState: convTalkState = .inactive
    private var answerState: convTalkState = .inactive
    
    @Published var transcript: String = ""
    @Published var isRecording: Bool = false
    @Published var originalAudioDuration: Float = 0.0
    @Published var splicedAudioDuration: Float = 0.0
    @Published var predictedClass: String = ""
    @Published var resultCode: Int = -1
    @Published var fullRecordedAudioURL: URL? = nil
    
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
    
    @Published var totalWrong: Int = 0
    
    private let speechSynthesizer = AVSpeechSynthesizer()
    @Published var isSpeaking: Bool = false
//    private let speechSynthesizer: SpeechSynthesizerProviding = SpeechSynthesizer()
    
    @Published var auntiTalk: [ConvTalk] = []
    @Published var auntiIdx: Int = 0
    @Published var userTalk: [ConvTalk] = []
    @Published var userIdx: Int = 0
    @Published var isUserTurn: Bool = true
    
    @Published var btnRecordState: btnRecordState = .record
    
    init(topic: ConvTopic) {
        self.selectedTopic = topic
        self.questionn = topic.dialogs[activeIndex].question
        self.answer = topic.dialogs[activeIndex].answer
        
        self.auntiTalk = topic.botTalk
        self.userTalk = topic.userTalk
        
//        self.chatField.append(topic.dialogs[activeIndex].question)
    }
    
    
    
    func getCurrentRecordState() -> String {
        switch self.btnRecordState {
        case .record:
            return "microphone.fill"
        case .stop:
            return "stop.fill"
        case .submit:
            return "paperplane.fill"
        case .giveup:
            return "chevron.right.2"
        }
    }
    
    func nextConversation(_ callback: (_ isFinish: Bool) -> Void = {isFinish in }) {
        if isUserTurn {
            self.auntiIdx += 1
            callback(auntiIdx >= auntiTalk.count)
            self.isUserTurn = false
        } else {
            self.userIdx += 1
            self.isUserTurn = true
        }
    }
    
    func getActiveIndex() -> Int {
        return activeIndex + 1
    }
    
    func progressFormatting() -> String {
        return "\(userIdx + 1)/\(userTalk.count)"
    }
    
    func progressPercentage() -> Double {
        return Double((userIdx + 1)) / Double(userTalk.count) * 100
    }
    
    func append(_ text: String) {
        chat.append(text)
    }
    
    func tryAnswer() {
        chatField.append(ConvTalk(hanzi: "Muehehe salah een", pinyin: "IYam Iyam Iyam", translate: "Buahaha", isError: true)) //, isError: true
    }
    
    func checkDialogMax() -> Bool {
        return activeIndex < selectedTopic.dialogs.count - 1
    }
    
    func nextQuestion() {
        activeIndex += 1
    }
    
    func toggleChangeAuntieState(auntyState: auntieState) {
        switch auntyState {
        case .idle:
            break
        case .waiting:
            break
        case .answering:
            break
        }
    }
    
    func speakutterance(_ message: String, rate: Float = 0.5, pitch: Float = 1.0) {
        let utterance = AVSpeechUtterance(string: message)
        utterance.pitchMultiplier = pitch
        utterance.rate = rate
        utterance.voice = AVSpeechSynthesisVoice(language: "zh-CN")

        speechSynthesizer.speak(utterance)
    }
    
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
    
    func startRecordingReal() {
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
                       self.transcript.contains(self.userTalk[self.userIdx].wordPrevix),
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
    
    func stopRecordingReal() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionRequest?.endAudio()
        isRecording = false
        
        let sampleRate = audioEngine.inputNode.outputFormat(forBus: 0).sampleRate
        
        let fullBuffer = mergeBuffers(recordedBuffers)
        let fullDuration = Float(fullBuffer.frameLength) / Float(sampleRate)
        
        if let audioURL = saveBufferToFile(buffer: fullBuffer, sampleRate: sampleRate) {
                self.fullRecordedAudioURL = audioURL
            }
        
//        guard let beforeOffset = beforeTargetTimeOffset else {
//            self.resultCode = 8000
//            return 8000
//        }
//        
//        let startSample = Int(beforeOffset * sampleRate)
//        let endSample = Int((beforeOffset + Double(duration)) * sampleRate)
//        
//        let slicedBuffer = sliceBuffer(fullBuffer, fromSample: startSample, toSample: endSample)
//        let slicedDuration = Float(slicedBuffer.frameLength) / Float(sampleRate)
//        
//        self.originalAudioDuration = fullDuration
//        self.splicedAudioDuration = slicedDuration
//        
//        let result = classify(buffer: slicedBuffer, target: target)
//        return result
    }
    
    func anaylizeReal(duration: Float = 5.0) -> Int {
        let sampleRate = audioEngine.inputNode.outputFormat(forBus: 0).sampleRate
        let fullBuffer = mergeBuffers(recordedBuffers)
        let fullDuration = Float(fullBuffer.frameLength) / Float(sampleRate)
        
        
        guard let beforeOffset = beforeTargetTimeOffset else {
            self.resultCode = 8000
            return 8000
        }
        
        let startSample = Int(beforeOffset * sampleRate)
        let endSample = Int((beforeOffset + Double(duration)) * sampleRate)
        
        let slicedBuffer = sliceBuffer(fullBuffer, fromSample: startSample, toSample: endSample)
        let slicedDuration = Float(slicedBuffer.frameLength) / Float(sampleRate)
        
        self.originalAudioDuration = fullDuration
        self.splicedAudioDuration = slicedDuration
        
        let result = classify(buffer: slicedBuffer, target: userTalk[userIdx].highlight)
        return result
    }
    
    func captureAudio() {
        let sampleRate = audioEngine.inputNode.outputFormat(forBus: 0).sampleRate
        let fullBuffer = mergeBuffers(recordedBuffers)
        let fullDuration = Float(fullBuffer.frameLength) / Float(sampleRate)
        
        if let audioURL = saveBufferToFile(buffer: fullBuffer, sampleRate: sampleRate) {
                self.fullRecordedAudioURL = audioURL
            }
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
        let result = semaphore.wait(timeout: .now() + 2.0)

        if result == .timedOut {
            print("⚠️ Classification timeout — possibly due to too short input")
            self.resultCode = 8000
            return 8000
        }

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

extension DialogViewmodel: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        self.isSpeaking = true
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        self.isSpeaking = false
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        self.isSpeaking = false
        print("Finished speaking")
        try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
    }
}


private func saveBufferToFile(buffer: AVAudioPCMBuffer, sampleRate: Double) -> URL? {
    // Validate buffer
    guard buffer.frameLength > 0 else {
        print("❌ Error: Empty audio buffer - nothing to save")
        return nil
    }
    
    // Create unique filename
    let filename = "recording_\(Date().timeIntervalSince1970).caf"
    let fileURL = FileManager.default.temporaryDirectory.appendingPathComponent(filename)
    
    // Configure audio settings
    let settings: [String: Any] = [
        AVFormatIDKey: kAudioFormatLinearPCM,
        AVSampleRateKey: sampleRate,
        AVNumberOfChannelsKey: buffer.format.channelCount,
        AVLinearPCMBitDepthKey: 32,
        AVLinearPCMIsFloatKey: true,
        AVLinearPCMIsBigEndianKey: false
    ]
    
    do {
        print("💾 Attempting to save audio file with settings: \(settings)")
        let file = try AVAudioFile(forWriting: fileURL, settings: settings)
        try file.write(from: buffer)
        print("✅ Successfully saved audio to: \(fileURL)")
        return fileURL
    } catch {
        print("❌ Failed to save audio: \(error.localizedDescription)")
        return nil
    }
}
