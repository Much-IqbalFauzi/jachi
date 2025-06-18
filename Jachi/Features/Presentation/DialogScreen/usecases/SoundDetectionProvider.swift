//
//  SoundDetectionProvider.swift
//  Jachi
//
//  Created by Muchamad Iqbal Fauzi on 19/06/25.
//

import Combine
import Foundation
import SoundAnalysis

@Observable
class SoundDetectionProvider {
    // 1.
    @ObservationIgnored
    let soundAnalysisManager = SoundAnalysisManager.shared

    @ObservationIgnored
    var lastTime: Double = 0
    
    var detectionStarted = false
    var isFoundSound: Bool = false
    var identifiedSound: (identifier: String, confidence: String)?
    private var detectionCancellable: AnyCancellable? = nil

    // 2.
    private func formattedDetectionResult(_ result: SNClassificationResult, _ highlight: String) -> (
        identifier: String, confidence: String
    )? {
        guard let classification = result.classifications.first else {
            return nil
        }

        if lastTime == 0 {
            lastTime = result.timeRange.start.seconds
        }

//        let formattedTime = String(
//            format: "%.2f", result.timeRange.start.seconds - lastTime)

        let displayName = classification.identifier.replacingOccurrences(
            of: "_", with: " "
        ).capitalized
        let confidence = classification.confidence
        let confidencePercentString = String(
            format: "%.2f%%", confidence * 100.0)
        
        print(displayName, confidencePercentString)
        
        if displayName == highlight && (confidence * 100.0) >= 99 {
            isFoundSound = true
        }
        
        return (displayName, confidencePercentString)
    }

    // 3.
    func startDetection(_ highlight: String) {
        let classificationSubject = PassthroughSubject<
            SNClassificationResult, Error
        >()
        isFoundSound = false
        detectionCancellable =
            classificationSubject
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in self.detectionStarted = false },
                receiveValue: { result in
                    self.identifiedSound = self.formattedDetectionResult(result, highlight)
                })

        soundAnalysisManager.startSoundClassification(
            subject: classificationSubject)
    }

    // 4.
    func stopDetection() {
        lastTime = 0
        identifiedSound = nil
        soundAnalysisManager.stopSoundClassification()
    }
    
    func playSound() {
        soundAnalysisManager.playAudio()
    }
    
    
}
