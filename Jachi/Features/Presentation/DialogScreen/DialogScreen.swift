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

    init(topic: ConvTopic) {
        _vm = StateObject(wrappedValue: DialogViewmodel(topic: topic))
    }

    var body: some View {
        ZStack {
            ChatBg()
            Rectangle()
                .fill(Color.blizzardBlue)
                .opacity(0.3)
                .ignoresSafeArea()
            GeometryReader { reader in
                VStack(alignment: .trailing) {
                    HStack {
                        Image("aunti")
                            .resizable()
                            .scaledToFill()
                            .frame(height: 10)
                            .frame(width: 120)
                            .padding(.leading, 16)
                        VStack {
                            BorderedText("Auntie Jachi")
                                .frame(
                                    maxWidth: .infinity,
                                    alignment: .leading
                                )
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                            TextBubble(
                                isError: vm.answer.isError,
                                isUser: vm.answer.isUser,
                                speaker: {},
                                slow: {},
                                translate: {},
                                {
                                    vm.answer.buildHanzi(.dustPink)
                                        .padding(.top, 8)
                                        .padding(.bottom, 8)
                                    if (vm.answer.hanzi != "...") {
                                        vm.answer.buildPinyin(.dustPink)
                                            .padding(.bottom, 8)
                                    }
                                })
                        }
                        .padding(.trailing, 8)
                    }
                    .padding(.top, 56)
                    .padding(.bottom, 38)
                    
                    VStack {
                        BorderedText("You", isUser: vm.questionn.isUser)
                            .frame(
                                maxWidth: .infinity,
                                alignment: .trailing
                            )
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                        TextBubble(
                            isError: vm.questionn.isError,
                            isUser: vm.questionn.isUser,
                            speaker: {},
                            slow: {},
                            translate: {},
                            {
                                vm.questionn.buildHanzi()
                                    .padding(.top, 8)
                                    .padding(.bottom, 8)
                                vm.questionn.buildPinyin()
                                    .padding(.bottom, 8)
                            })
                    }
                    .padding(.horizontal, 8)
                    Spacer()
                    //                    ScrollView {
                    //                        ForEach(
                    //                            Array(zip(vm.chatField.indices, vm.chatField)),
                    //                            id: \.0
                    //                        ) { index, conversation in
                    //                            let conv: ConvTalk = conversation
                    //                            HStack {
                    //                                if !conv.isUser {
                    //                                    Image(systemName: "person.fill")
                    //                                        .resizable()
                    //                                        .frame(width: 30, height: 30)
                    //                                        .foregroundColor(.gray)
                    //                                }
                    //                                VStack {
                    //                                    if !conv.isUser {
                    //
                    //                                    }
                    //                                    HStack {
                    //                                        BorderedText(
                    //                                            conv.isUser ? "You" : "Auntie",
                    //                                            isUser: conv.isUser
                    //                                        )
                    //                                        .frame(
                    //                                            maxWidth: .infinity,
                    //                                            alignment: conv.isUser
                    //                                                ? .trailing : .leading)
                    //                                    }
                    //                                    .padding(.bottom, 4)
                    //                                    .padding(.horizontal, 16)
                    //                                    TextBubble(
                    //                                        isError: conv.isError,
                    //                                        isUser: conv.isUser,
                    //                                        speaker: {},
                    //                                        slow: {},
                    //                                        translate: {},
                    //                                        {
                    //                                            Text(conv.hanzi)
                    //                                                .font(.system(size: 24))
                    //                                                .fontWeight(.semibold)
                    //                                                .frame(
                    //                                                    maxWidth: .infinity,
                    //                                                    alignment: .leading)
                    //                                        })
                    //                                }
                    //                            }
                    //                            .padding(.horizontal, 16)
                    //                            .padding(.vertical, 8)
                    //                        }.rotationEffect(Angle(degrees: 180))
                    //                    }
                    //                    .rotationEffect(Angle(degrees: -180))
                    //                    .frame(width: reader.size.width)
                    //                    .frame(maxHeight: reader.size.height)
                    //                    .padding(.bottom, 16)

                    HStack {
                        BtnCircular(
                            icon: "microphone",
                            action: {
                                //                                vm.tryAnswer()
                            })

                        BtnCircular(
                            icon: "microbe",
                            action: {
                                //                                vm.rightAnswer()
                            }
                        )
                        .padding(.leading, 16)

                        BtnCircular(
                            icon: "pencil",
                            action: {
                                //                                vm.rightAnswer()
                            }
                        )
                        .padding(.leading, 16)
                    }
                    .padding(.top, 32)
                    .frame(width: reader.size.width)
                    .background(Color.dustBlizzard)
//                    .ignoresSafeArea()
                }
                .frame(width: reader.size.width, height: reader.size.height)
            }
        }
    }
}

#Preview {
    DialogScreen(topic: .topic1)
}
