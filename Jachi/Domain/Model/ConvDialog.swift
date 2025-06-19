//
//  ConvDialog.swift
//  Jachi
//
//  Created by Muchamad Iqbal Fauzi on 15/06/25.
//

import Foundation

class ConvDialog {
    var id: UUID
    var question: ConvTalk
    var answer: ConvTalk
    
    init(question: ConvTalk, answer: ConvTalk) {
        self.id = UUID()
        self.question = question
        self.answer = answer
    }
}

extension ConvDialog {
    // keyi dazhe ma
    static let convo1 = ConvDialog(question: .talkUser1, answer: .talkAuntie1)
    static let convo2 = ConvDialog(question: .talkUser2, answer: .talkAuntie2)
    static let convo3 = ConvDialog(question: .talkUser3, answer: .talkAuntie3)
    static let convo4 = ConvDialog(question: .talkUser4, answer: .talkAuntie4)
    static let convo5 = ConvDialog(question: .talkUser5, answer: .emptyTalk)
    
//    // you cuxiao ma
//    static let convo6 = ConvDialog(question: .talkUser6, answer: .talkAuntie6)
//    static let convo7 = ConvDialog(question: .talkUser7, answer: .talkAuntie7)
//    static let convo8 = ConvDialog(question: .talkUser8, answer: .talkAuntie8)
//    static let convo9 = ConvDialog(question: .talkUser9, answer: .talkAuntie9)
//    static let convo10 = ConvDialog(question: .talkUser10, answer: .emptyTalk)
    
    // xiao long bao
    static let convo11 = ConvDialog(question: .emptyTalk, answer: .talkUser11)
    static let convo12 = ConvDialog(question: .talkAuntie12, answer: .talkUser12)
    static let convo13 = ConvDialog(question: .talkAuntie13, answer: .talkUser13)
    static let convo14 = ConvDialog(question: .talkAuntie14, answer: .emptyTalk)
    
//    // miantiao
//    static let convo15 = ConvDialog(question: .talkAuntie15, answer: .talkUser15)
//    static let convo16 = ConvDialog(question: .talkAuntie16, answer: .talkUser16)
//    static let convo17 = ConvDialog(question: .talkAuntie17, answer: .talkUser17)
//    static let convo18 = ConvDialog(question: .talkAuntie18, answer: .emptyTalk)
}
