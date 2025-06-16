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

    init(name: String, hanzi: String, dialog: [ConvDialog] = []) {
        self.id = UUID()
        self.name = name
        self.hanzi = hanzi
        self.dialogs = dialog
    }
}

extension ConvTopic {
    static let topic1 = ConvTopic(
        name: "Can i get a discount?",
        hanzi: "可以打折吗",
        dialog: [
            .convo1,
            .convo2,
            .convo3,
            .convo4,
            .convo5
        ])
    
    static let topic2 = ConvTopic(
        name: "Is there any promo?",
        hanzi: "有促狭吗",
        dialog: [
            .convo6,
            .convo7,
            .convo8,
            .convo9,
            .convo10
        ])
    
    static let topic3 = ConvTopic(
        name: "Xiaolongbao",
        hanzi: "小笼包",
        dialog: [
            .convo11,
            .convo12,
            .convo13,
            .convo14
        ])
    
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
