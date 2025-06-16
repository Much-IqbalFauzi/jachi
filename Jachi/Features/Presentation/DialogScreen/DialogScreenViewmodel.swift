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
    
    @Published var questionn: ConvTalk = .emptyTalk
    @Published var answer: ConvTalk = .emptyTalk
    
    private var questionState: convTalkState = .inactive
    private var answerState: convTalkState = .inactive
    
    @Published private(set) var questionColorState: Color = .dustPink
    @Published private(set) var answerColorState: Color = .dustBlizzard
    
    init(topic: ConvTopic) {
        self.selectedTopic = topic
        
        chatField.append(topic.dialogs[activeIndex].question)
        
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
    
    func changeQuestionState(convState: convTalkState = .inactive) {
        switch convState {
        case .active:
            questionColorState = .dustPink
        case .inactive:
            questionColorState = .dustPink
        case .correct:
            questionColorState = .dustBlizzard
        case .incorrect:
            questionColorState = .dustBlizzard
        }
    }
    
}



