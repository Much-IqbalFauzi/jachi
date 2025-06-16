//
//  BubbleState.swift
//  Jachi
//
//  Created by Muchamad Iqbal Fauzi on 16/06/25.
//

import SwiftUI

class BubbleState {
    var primary: Color
    var bg: Color
    
    init() {
        self.primary = .dustBlizzard
        self.bg = .lynxWhite
    }
    
    func toggleState(state: convTalkState) {
        switch state {
        case .active:
            self.primary = .dustBlizzard
            self.bg = .lynxWhite
        case .inactive:
            self.primary = .dustGray
            self.bg = .smokeGray
        case .correct:
            self.primary = .dustBlizzard
            self.bg = .dustBlizzard
        case .incorrect:
            self.primary = .dustBlizzard
            self.bg = .dustBlizzard
        case .activeAuntie:
            self.primary = .dustPink
            self.bg = .lynxWhite
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
