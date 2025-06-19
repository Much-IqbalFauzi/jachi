//
//  FinishScreen.swift
//  Jachi
//
//  Created by Muchamad Iqbal Fauzi on 19/06/25.
//

import SwiftUI

struct FinishScreen: View {
    @EnvironmentObject var navigation: Navigation
    
    @ObservedObject private var animationTimer: TimerState = .init()
    
    
    private var streak: StreakObject
    
    init (streak: StreakObject) {
        self.streak = streak
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Practice Complete")
                    .foregroundStyle(Color.dustBlizzard)
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                Image("end")
                Text("Added Your Streak")
                    .foregroundStyle(Color.dustBlizzard)
                    .font(.system(size: 32, weight: .semibold, design: .rounded))
                    .padding(.vertical, 16)
                Text("Keep streaking your\nlearning process")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 18, weight: .light, design: .rounded))
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color.smokeYellow)
            .onReceive(animationTimer.timer) { timer in
                animationTimer.updateTimerString()
                if animationTimer.timerString == "2.0" {
                    streak.streak += 1
                    navigation.pop()
                    navigation.pop()
                    
                }
            }
            .onAppear {
                animationTimer.startTime = Date()
                animationTimer.start()
            }
        }
        
    }
}


//#Preview {
//    FinishScreen()
//}
