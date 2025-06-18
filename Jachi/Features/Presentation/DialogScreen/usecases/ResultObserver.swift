//
//  ResultObserver.swift
//  Jachi
//
//  Created by Muchamad Iqbal Fauzi on 18/06/25.
//

import SoundAnalysis
import Combine

class ResultsObserver: NSObject, SNResultsObserving {
        // 1.
        private let subject: PassthroughSubject<SNClassificationResult, Error>
        
        init(subject: PassthroughSubject<SNClassificationResult, Error>) {
            self.subject = subject
        }
        
        // 2.
        func request(_ request: SNRequest, didProduce result: SNResult) {
            if let result = result as? SNClassificationResult {
                subject.send(result)
            }
        }
        
        // 3.
        func request(_ request: SNRequest, didFailWithError error: Error) {
            print("The analysis failed: \\(error.localizedDescription)")
            subject.send(completion: .failure(error))
        }
        
        // 4.
        func requestDidComplete(_ request: SNRequest) {
            print("The request completed successfully!")
            subject.send(completion: .finished)
        }
}
