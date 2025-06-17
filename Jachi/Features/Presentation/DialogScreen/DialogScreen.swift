//
//  DialogScreen.swift
//  Jachi
//
//  Created by Muchamad Iqbal Fauzi on 12/06/25.
//

import Combine
import SwiftUI

struct DialogScreen: View {

    @EnvironmentObject var navigation: Navigation
    @StateObject private var vm: DialogViewmodel
    
    @StateObject private var recognizer = SpeechRecognizer()

    @StateObject private var userBubble: BubbleState = .init()
    @StateObject private var botBubble: BubbleState = .init(
        primary: .blizzardBlue, bg: .autumnYellow)

    @StateObject private var botChibi: ChibiState = .init()

    init(topic: ConvTopic) {
        _vm = StateObject(wrappedValue: DialogViewmodel(topic: topic))
    }

    var body: some View {
        ZStack {
            ChatBg()
//            Rectangle()
//                .fill(Color.oceanBlue)
//                .opacity(0.9)
//                .ignoresSafeArea()
            GeometryReader { reader in
                VStack {
                    HStack(alignment: .center) {
                        ProgressView(
                            value: 0.3,
                            label: {},
                            currentValueLabel: {
                                Text("\(vm.progressFormatting())").padding(
                                    .top, -30)
                            }
                        )
                        .progressViewStyle(Progress())
                    }
                    .padding(.bottom, 16)
                    .padding(.top, 32)
                    .padding(.horizontal, 16)
                    .background(Color.smokeYellow)
                    .frame(width: reader.size.width)
                    .scaledToFit()

                    HStack {
                        Image(botChibi.state)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 10)
                            .frame(width: 120)
                            .padding(.leading, 16)
                        VStack {
                            Text("Auntie Jachi")
                                .font(.system(size: 16, weight: .semibold))
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .foregroundColor(Color(botBubble.primary))
                                .background(Color(botBubble.bg))
                                .cornerRadius(16)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(
                                            Color(botBubble.primary),
                                            lineWidth: 2)
                                }
                                //                            BorderedText("Auntie Jachi", bubbleState: botBubble)
                                .frame(
                                    maxWidth: .infinity,
                                    alignment: .leading
                                )
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                            TextBubble(
                                bubbleState: botBubble,
                                isError: vm.answer.isError,
                                isUser: vm.answer.isUser,
                                speaker: {},
                                slow: {},
                                translate: {},
                                {
                                    vm.answer.buildHanzi(botBubble.primary)
                                        .padding(.top, 8)
                                        .padding(.bottom, 8)
                                    if vm.answer.hanzi != "..." {
                                        vm.answer.buildPinyin(botBubble.primary)
                                            .padding(.bottom, 8)
                                    }
                                })
                        }
                        .padding(.trailing, 8)
                    }
                    .padding(.top, 32)
                    .padding(.bottom, 12)
                    
                    VStack {
                        HStack {
                            Text("You")
                                .font(.system(size: 16, weight: .semibold))
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .foregroundColor(Color(userBubble.primary))
                                .background(Color(userBubble.bg))
                                .cornerRadius(16)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(
                                            Color(userBubble.primary),
                                            lineWidth: 2)
                                }
//                            BorderedText("You", bubbleState: userBubble)
                                .frame(
                                    maxWidth: .infinity,
                                    alignment: .trailing
                                )
                                .padding(.horizontal, 16)
                            Image(
                                userBubble.isActive
                                    ? "ico-user" : "ico-user-disable"
                            )
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .padding(.trailing, 16)
                            .padding(.leading, -8)
                        }
                        .padding(.vertical, 8)
                        TextBubble(
                            bubbleState: userBubble,
                            isError: vm.questionn.isError,
                            isUser: vm.questionn.isUser,
                            speaker: {},
                            slow: {},
                            translate: {},
                            {
                                vm.questionn.buildHanzi(userBubble.primary)
                                    .padding(.top, 8)
                                    .padding(.bottom, 8)
                                vm.questionn.buildPinyin(userBubble.primary)
                                    .padding(.bottom, 8)
                            })
                    }
                    .padding(.horizontal, 8)
                    Spacer()

                    Hint("Hero za warudo")
                        .frame(
                            maxWidth: .infinity,
                            alignment: .center
                        )
                        .padding()

                    Spacer()
                    HStack {
                        BtnCircular(
                            icon: vm.isRecording ? "pause.fill": "microphone.fill",
                            fill: .dustBlizzard,
                            action: {
                                self.toggleRecording()
//                                changeBotState(.inactive)
//                                changeUserState(.active)
                                
                            })
                    }
                    .padding(.top, 24)
                    .frame(width: reader.size.width)
                    .background(Color.dustBlizzard)
                    //                    .ignoresSafeArea()
                }
                .frame(width: reader.size.width, height: reader.size.height)
            }
        }
    }

    private func changeUserState(_ state: convTalkState) {
        userBubble.toggleState(state: state)

    }

    private func changeBotState(_ state: convTalkState) {
        botBubble.toggleState(state: state)

        botChibi.toggleActive()
    }
    
    private func toggleRecording() {
        let userTalk = vm.questionn
        
        if !vm.isRecording {
            let result = vm.stopRecordingReal(
                target: vm.questionn.highlight,
                duration: 2.0
            )
            
            print("the result is \(result)")
            
            if result > 0 && result < 101 {
                moveToNextDialogue()
            }
        } else {
            vm.startRecordingReal(
                beforeTarget: userTalk.wordPrevix,
                target: userTalk.highlight,
                duration: 2.0
            )
            vm.resultCode = -1
            vm.originalAudioDuration = 0
            vm.predictedClass = ""
        }
        vm.isRecording.toggle()
    }

    private func moveToNextDialogue() {
        if vm.checkDialogMax() {
            vm.nextQuestion()
        } else {
            print("Do something")
        }
    }
}

#Preview {
    DialogScreen(topic: .topic1)
}
