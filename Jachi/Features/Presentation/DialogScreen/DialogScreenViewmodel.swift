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
    
    @Published private(set) var chatField: [ConvTalk] = []
    
    private var activeIndex: Int = 0
    private var isAnswerCorrect: Bool = false
    
    private var selectedTopic: ConvTopic
    
    init(topic: ConvTopic) {
        self.selectedTopic = topic
//        if (activeIndex == 0 && topic.dialogs[activeIndex].question.highlight == "") {
//            chatField.append(topic.dialogs[activeIndex].question)
//        }
        chatField.append(topic.dialogs[activeIndex].question)
        
    }
    
    func append(_ text: String) {
        chat.append(text)
    }
    
    func tryAnswer() {
        chatField.append(ConvTalk(hanzi: "Muehehe salah een", pinyin: "IYam Iyam Iyam", translate: "Buahaha", isError: true))
    }
    
    func rightAnswer() {
        activeIndex += 1
        chatField.append(selectedTopic.dialogs[activeIndex].answer)
    }
    
}



