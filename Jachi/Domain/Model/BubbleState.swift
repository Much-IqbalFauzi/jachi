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
            self.primary = .dustBlizzard
            self.bg = .lynxWhite
        case .correct:
            self.primary = .dustBlizzard
            self.bg = .dustBlizzard
        case .incorrect:
            self.primary = .dustBlizzard
            self.bg = .dustBlizzard
        }
    }
}

enum convTalkState {
    case active
    case inactive
    case correct
    case incorrect
}
