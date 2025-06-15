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
    static let convo1 = ConvDialog(question: .talkUser1, answer: .talkAuntie1)
    static let convo2 = ConvDialog(question: .talkUser2, answer: .talkAuntie2)
    static let convo3 = ConvDialog(question: .talkUser3, answer: .talkAuntie3)
    static let convo4 = ConvDialog(question: .talkUser4, answer: .talkAuntie4)
    static let convo5 = ConvDialog(question: .talkUser5, answer: .emptyTalk)
}
