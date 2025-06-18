//
//  SpeechProvider.swift
//  Jachi
//
//  Created by Muchamad Iqbal Fauzi on 18/06/25.
//

import AVFoundation

protocol SpeechSynthesizerProviding {
    func speakText(_ text: String)
}

final class SpeechSynthesizer: SpeechSynthesizerProviding {
    func speakText(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
}
