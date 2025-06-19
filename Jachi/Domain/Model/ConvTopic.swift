//
//  ConvTopic.swift
//  Jachi
//
//  Created by Muchamad Iqbal Fauzi on 15/06/25.
//

import Foundation

class ConvTopic {
    var id: UUID
    var name: String
    var hanzi: String
    var dialogs: [ConvDialog] = []
    var userTalk: [ConvTalk] = []
    var botTalk: [ConvTalk] = []

    init(name: String, hanzi: String, dialog: [ConvDialog] = [], userTalk: [ConvTalk] = [], botTalk: [ConvTalk] = []) {
        self.id = UUID()
        self.name = name
        self.hanzi = hanzi
        self.dialogs = dialog
        self.userTalk = userTalk
        self.botTalk = botTalk
    }
}

extension ConvTopic {
    static let topic1 = ConvTopic(
        name: "Buying Snacks",
        hanzi: "买小零食", //keyidazhe
        dialog: [
            .convo1,
            .convo2,
            .convo3,
            .convo4,
            .convo5
        ],
        userTalk: [
            .talkUser1,
            .talkUser2,
            .talkUser3,
            .talkUser4,
            .talkUser5
        ],
        botTalk: [
            .emptyTalk,
            .talkAuntie1,
            .talkAuntie2,
            .talkAuntie3,
            .talkAuntie4,
            .emptyTalk
        ]
    )
    
    static let topic2 = ConvTopic(
        name: "Buying Little Baskets Bun",
        hanzi: "三分七十快，我们的东西是精选的",
        dialog: [
            .convo6,
            .convo7,
            .convo8,
            .convo9,
            .convo10
        ])
    
    static let topic3 = ConvTopic(
        name: "Buying Xiaolongbao",
        hanzi: "买小笼包",
        dialog: [
            .convo11,
            .convo12,
            .convo13,
            .convo14,
            .convo15
        ],
        userTalk: [
            .talkUser11,
            .talkUser12,
            .talkUser13,
            .talkUser14,
            .talkUser15
        ],
        botTalk: [
            .emptyTalk,
            .talkAuntie11,
            .talkAuntie12,
            .talkAuntie13,
            .talkAuntie14,
            .emptyTalk
        ]
    )
    
    static let topic4 = ConvTopic(
        name: "Noodles",
        hanzi: "面条",
        dialog: [
            .convo15,
            .convo16,
            .convo17,
            .convo18
        ])
}

extension ConvTopic: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: ConvTopic, rhs: ConvTopic) -> Bool {
        return lhs.id == rhs.id
    }
}
