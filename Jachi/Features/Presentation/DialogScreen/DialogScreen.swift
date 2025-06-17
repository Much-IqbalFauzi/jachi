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

    @StateObject private var userBubble: BubbleState = .init()
    @StateObject private var botBubble: BubbleState = .init(
        primary: .dustPink, bg: .lynxWhite)

    @StateObject private var botChibi: ChibiState = .init()

    init(topic: ConvTopic) {
        _vm = StateObject(wrappedValue: DialogViewmodel(topic: topic))
    }

    var body: some View {
        ZStack {
            ChatBg()
            Rectangle()
                .fill(Color.dustBlizzard)
                .opacity(0.4)
                .ignoresSafeArea()
            GeometryReader { reader in
                VStack(alignment: .trailing) {
                    VStack(alignment: .center) {
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
                    .padding(.horizontal, 16)
                    .frame(width: reader.size.width)

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
                                            lineWidth: 4)
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
                    .padding(.top, 56)
                    .padding(.bottom, 38)

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
                                            lineWidth: 4)
                                }
//                            BorderedText("You", bubbleState: userBubble)
                                .frame(
                                    maxWidth: .infinity,
                                    alignment: .trailing
                                )
                                .padding(.horizontal, 16)
                            Image(
                                userBubble.isActive
                                    ? "persona" : "persona-disable"
                            )
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44, height: 44)
                            .padding(.trailing, 16)
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

                    Hint("Hero za warudo")
                        .frame(
                            maxWidth: .infinity,
                            alignment: .center
                        )
                        .padding()

                    Spacer()
                    HStack {
                        BtnCircular(
                            icon: "microphone",
                            action: {
                                //                                vm.changeAnswerState(convState: .inactive)
                                //                                print("Microphone tapped")
                                changeBotState(.inactive)
                                changeUserState(.active)
                            })

                        BtnCircular(
                            icon: "microbe",
                            action: {
                                //                                vm.getCurrentColorState()
                                changeBotState(.activeAuntie)
                                changeUserState(.inactive)
                            }
                        )
                        .padding(.leading, 16)

                        BtnCircular(
                            icon: "pencil",
                            action: {
                                //                                vm.changeAnswerState(convState: .activeAuntie)

                                botChibi.changeState(.smile)
                            }
                        )
                        .padding(.leading, 16)
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
}

#Preview {
    DialogScreen(topic: .topic1)
}
