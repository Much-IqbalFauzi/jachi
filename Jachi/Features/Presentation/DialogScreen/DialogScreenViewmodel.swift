//
//  DialogViewmodel.swift
//  Jachi
//
//  Created by Muchamad Iqbal Fauzi on 12/06/25.
//

import Foundation
import SwiftUI

enum auntieState {
    case idle
    case waiting
    case answering
}

class DialogViewmodel: ObservableObject {
    @Published var title: String = "Dialogue De Umerto"
    
    @Published private(set) var chat: [String] = []
    
    @Published private(set) var chatField: [ConvTalk] = []
    
    private var activeIndex: Int = 0
    private var isAnswerCorrect: Bool = false
    
    private var selectedTopic: ConvTopic
    
    @Published var questionn: ConvTalk = .emptyTalk
    @Published var answer: ConvTalk = .emptyTalk
    
    private var questionState: convTalkState = .inactive
    private var answerState: convTalkState = .inactive
    
    
    init(topic: ConvTopic) {
        self.selectedTopic = topic
        self.questionn = topic.dialogs[activeIndex].question
        self.answer = topic.dialogs[activeIndex].answer
        
        chatField.append(topic.dialogs[activeIndex].question)
    }
    
    func getActiveIndex() -> Int {
        return activeIndex + 1
    }
    
    func progressFormatting() -> String {
        return "\(getActiveIndex())/\(selectedTopic.dialogs.count)"
    }
    
    func append(_ text: String) {
        chat.append(text)
    }
    
    func tryAnswer() {
        chatField.append(ConvTalk(hanzi: "Muehehe salah een", pinyin: "IYam Iyam Iyam", translate: "Buahaha", isError: true)) //, isError: true
    }
    
    func rightAnswer() {
        activeIndex += 1
        chatField.append(selectedTopic.dialogs[activeIndex].answer)
    }
    
    func nextQuestion() {
        activeIndex += 1
    }
    
    func toggleChangeAuntieState(auntyState: auntieState) {
        switch auntyState {
        case .idle:
            break
        case .waiting:
            break
        case .answering:
            break
        }
    }
}



