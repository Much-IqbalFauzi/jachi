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
    var dialogs: [ConvDialog] = []

    init(name: String, dialog: [ConvDialog] = []) {
        self.id = UUID()
        self.name = name
        self.dialogs = dialog
    }
}

extension ConvTopic {
    static let topic1 = ConvTopic(
        name: "Hokya-Hokya Ada Promo",
        dialog: [
            .convo1,
            .convo2,
            .convo3,
            .convo4,
            .convo5
        ])
}
