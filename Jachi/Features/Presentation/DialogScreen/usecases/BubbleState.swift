//
//  BubbleState.swift
//  Jachi
//
//  Created by Muchamad Iqbal Fauzi on 16/06/25.
//

import SwiftUI
import Foundation

class BubbleState: ObservableObject {
    @Published private(set) var primary: Color
    @Published private(set) var bg: Color
    @Published private(set) var isActive: Bool
    
    init() {
        self.primary = .dustBlizzard
        self.bg = .lynxWhite
        self.isActive = true
    }
    
    init (primary: Color, bg: Color) {
        self.primary = primary
        self.bg = bg
        self.isActive = true
    }
    
    func toggleState(state: convTalkState) {
        switch state {
        case .active:
            self.primary = .blizzardBlue
            self.bg = .lynxWhite
            self.isActive = true
        case .inactive:
            self.primary = .blizzardBlue
            self.bg = .smokeGray
            self.isActive = false
        case .correct:
            self.primary = .blizzardBlue
            self.bg = .lynxWhite
            self.isActive = true
        case .incorrect:
            self.primary = .crimson
            self.bg = .candyFloss
            self.isActive = true
        case .activeAuntie:
            self.primary = .blizzardBlue
            self.bg = .smokeYellow
            self.isActive = false
        }
    }
}

enum convTalkState {
    case active
    case inactive
    case correct
    case incorrect
    case activeAuntie
}
