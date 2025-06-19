//
//  DialogViewmodel.swift
//  Jachi
//
//  Created by Muchamad Iqbal Fauzi on 12/06/25.
//

import AVFoundation
import Combine
import CoreML
import Foundation
import SoundAnalysis
import Speech
import SwiftUI

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
    
    private var activeIndex: Int = 0
    private var isAnswerCorrect: Bool = false

    private var selectedTopic: ConvTopic

    private let speechSynthesizer = AVSpeechSynthesizer()
    
    @Published var isSpeaking: Bool = false
    @Published var totalWrong: Int = 0
    
    @Published var auntiTalk: [ConvTalk] = []
    @Published var auntiIdx: Int = 0
    @Published var userTalk: [ConvTalk] = []
    @Published var userIdx: Int = 0
    @Published var isUserTurn: Bool = true

    @Published var btnRecordState: btnRecordState = .record
    
    @Published var isIntroductionShown: Bool = true

    init(topic: ConvTopic) {
        self.selectedTopic = topic

        self.auntiTalk = topic.botTalk
        self.userTalk = topic.userTalk
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
            return "forward.end.fill"
        }
    }

    func nextConversation(
        _ callback: (_ isFinish: Bool) -> Void = { isFinish in }
    ) {
        callback((userIdx + 1) >= (userTalk.count - 1) || userIdx == userTalk.count || userTalk[userIdx].hanzi == "")
        if isUserTurn {
            self.auntiIdx += 1
//            callback(auntiIdx >= auntiTalk.count || userIdx == userTalk.count || userTalk[userIdx].hanzi == "")
            speakutterance(
                self.auntiTalk[self.auntiIdx].hanzi,
                pitch: -4
            )
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

    func speakutterance(
        _ message: String, rate: Float = 0.5, pitch: Float = 1.0
    ) {
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
}
