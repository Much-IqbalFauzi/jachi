//
//  FinishScreen.swift
//  Jachi
//
//  Created by Muchamad Iqbal Fauzi on 19/06/25.
//

import SwiftUI
import SwiftData

struct FinishScreen: View {
    @EnvironmentObject var navigation: Navigation
    @Query var streaks: [StreakLearn]
    @Environment(\.modelContext) private var context: ModelContext
    
    @ObservedObject private var animationTimer: TimerState = .init()
    
    
    var body: some View {
        let counter = streaks.first ?? StreakLearn()
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
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    if dateFormatter.string(for: Date()) != dateFormatter.string(for: counter.lastDate) {
                        counter.total += 1
                    }
                    navigation.pop()
                    navigation.pop()
                    
                }
            }
            .onAppear {
                if streaks.isEmpty {
                    context.insert(counter)
                }
                animationTimer.startTime = Date()
                animationTimer.start()
            }
        }
    }
}

#Preview {
    FinishScreen()
}
