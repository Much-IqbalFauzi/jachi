//
//  DialogViewmodel.swift
//  Jachi
//
//  Created by Muchamad Iqbal Fauzi on 12/06/25.
//

import Foundation
import SwiftUI

class DialogViewmodel: ObservableObject {
    @Published var title: String = "Dialogue De Umerto"
    
    @Published private(set) var chat: [String] = []
    
    private var selectedTopic: ConvTopic
    
    init(topic: ConvTopic) {
        self.selectedTopic = topic
    }
    
    func append(_ text: String) {
        chat.append(text)
    }
    
}



