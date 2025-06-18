//
//  TimerState.swift
//  Jachi
//
//  Created by Muchamad Iqbal Fauzi on 17/06/25.
//

import Foundation
import SwiftUI

class TimerState: ObservableObject {
    @Published private(set) var isRunning: Bool = false
    @Published var startTime: Date = Date()
    @Published var timerString: String = "0.00"
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func start() {
        self.timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
        self.isRunning = true
    }
    
    func stop() {
        self.timer.upstream.connect().cancel()
        self.isRunning = false
    }
    
    func reset() {
        self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        self.timerString = "0.00"
        self.isRunning = false
    }
    
    func updateTimerString() {
        if self.isRunning {
            self.timerString = String(
                format: "%.1f",
                (Date().timeIntervalSince(
                    self.startTime)))
        }
    }
    
}
