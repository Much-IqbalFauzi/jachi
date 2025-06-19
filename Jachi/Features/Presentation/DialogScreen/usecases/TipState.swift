//
//  TipState.swift
//  Jachi
//
//  Created by Muchamad Iqbal Fauzi on 18/06/25.
//

import Foundation
import SwiftUI

class TipState: ObservableObject {
    @Published private(set) var tipText: String = "Click the speaker button to hear the santence"
    @Published private(set) var isShowTip: Bool = true

    func toggleChangeTip(_ state: tipState, _ isShow: Bool) {
        self.isShowTip = isShow
        
        switch state {
        case .netral:
            self.tipText = ""
        case .intro:
            self.tipText =
                "Click the speaker button to hear the santence"
        case .starter:
            self.tipText =
                "Practice to pronounce this sentence on the Mic"
        case .right:
            self.tipText =
                "You pronounced it right!"
        case .wrong:
            self.tipText =
                "Play the Speaker again for the right pronounce reference"
        case .finish:
            self.tipText =
                "Hmmm, how about we move on and keep practicing!"
        }
    }
}

enum tipState {
    case netral
    case intro
    case starter
    case right
    case wrong
    case finish
}
