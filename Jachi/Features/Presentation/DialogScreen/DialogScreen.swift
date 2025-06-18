//
//  DialogScreen.swift
//  Jachi
//
//  Created by Muchamad Iqbal Fauzi on 12/06/25.
//

import Combine
import Foundation
import SwiftUI

struct DialogScreen: View {

    @EnvironmentObject var navigation: Navigation
    @StateObject private var vm: DialogViewmodel

    @StateObject private var recognizer = SpeechRecognizer()

    @StateObject private var userBubble: BubbleState = .init()
    @StateObject private var botBubble: BubbleState = .init(
        primary: .dustBlizzard, bg: .smokeGray)

    @StateObject private var botChibi: ChibiState = .init()

    @ObservedObject private var recordTimer: TimerState = .init()
    @ObservedObject private var animationTimer: TimerState = .init()

    @State private var isAnimatingView: Bool = false

    init(topic: ConvTopic) {
        _vm = StateObject(wrappedValue: DialogViewmodel(topic: topic))
    }

    var body: some View {
        ZStack {
            ChatBg()
            GeometryReader { reader in
                VStack(alignment: .center) {
                    HStack(alignment: .center) {
                        ProgressView(
                            value: 1,
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

                    Rectangle()
                        .fill(Color.lightGreen)
                        .frame(height: 5)
                        .frame(
                            width: isAnimatingView ? reader.size.width : 0,
                            alignment: .leading
                        )
                        .animation(
                            .linear(duration: 2),
                            value: isAnimatingView
                        )
                        .opacity(isAnimatingView ? 1 : 0)
                        .onReceive(animationTimer.timer) { timer in
                            animationTimer.updateTimerString()
                            readAnimationTimer()
                        }
                        .padding(.top, -8)

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
                                speaker: {
                                    vm.speakutterance(
                                        vm.auntiTalk[vm.auntiIdx].hanzi,
                                        pitch: -4)
                                },
                                slow: {
                                    vm.speakutterance(
                                        vm.auntiTalk[vm.auntiIdx].hanzi,
                                        rate: 0.0001, pitch: -4)
                                    print("the speaker state is: \(vm.isSpeaking)")
                                },
                                translate: {},
                                {
                                    vm.auntiTalk[vm.auntiIdx].buildHanzi(
                                        botBubble.primary
                                    )
                                    .padding(.top, 8)
                                    .padding(.bottom, 8)
                                    if vm.auntiTalk[vm.auntiIdx].hanzi != "" {
                                        vm.auntiTalk[vm.auntiIdx].buildPinyin(
                                            botBubble.primary
                                        )
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
                        }
                        .padding(.vertical, 8)
                        TextBubble(
                            bubbleState: userBubble,
                            isError: vm.questionn.isError,
                            isUser: vm.questionn.isUser,
                            speaker: {
                                vm.speakutterance(
                                    vm.userTalk[vm.userIdx].hanzi,
                                    pitch: -4)
                            },
                            slow: {
                                vm.speakutterance(
                                    vm.userTalk[vm.userIdx].hanzi, rate: 0.0001,
                                    pitch: -4)
                            },
                            translate: {},
                            {
                                vm.userTalk[vm.userIdx].buildHanzi(
                                    userBubble.primary
                                )
                                .padding(.top, 8)
                                .padding(.bottom, 8)
                                vm.userTalk[vm.userIdx].buildPinyin(
                                    userBubble.primary
                                )
                                .padding(.bottom, 8)
                            })
                    }
                    .padding(.horizontal, 8)
                    Spacer()

                    Tips({
                        Text("Muehehehehe")
                    })
                    .padding(.horizontal, 48)

                    Spacer()
                    Text(stringTimer())
                        .foregroundStyle(Color.lynxWhite)
                        .onReceive(recordTimer.timer) { _ in
                            recordTimer.updateTimerString()
                        }

                    HStack {
                        BtnCircular(
                            icon: vm.getCurrentRecordState(),
                            fill: .dustBlizzard,
                            action: recordButtonAction)
                    }
                    .padding(.top, 24)
                    .frame(width: reader.size.width)
                    //                    .background(Color.dustBlizzard)
                    //                    .ignoresSafeArea()
                }
                .frame(width: reader.size.width, height: reader.size.height)
            }
        }
    }

    private func recordButtonAction() {
        switch vm.btnRecordState {
        case .record:
            recordTimer.startTime = Date()
            recordTimer.start()
            vm.btnRecordState = .stop
        case .stop:
            recordTimer.stop()
            vm.btnRecordState = .submit
        case .submit:
            vm.btnRecordState = .record
            vm.nextConversation({
                botChibi.toggleActive()
                botBubble.toggleState(state: .activeAuntie)
                userBubble.toggleState(state: .inactive)
                runAnimationTimer()
            })
            recordTimer.reset()
        }
    }

    private func stringTimer() -> String {
        return vm.btnRecordState == .stop || vm.btnRecordState == .submit
            ? "Timer: \(recordTimer.timerString)" : ""
    }

    private func runAnimationTimer() {
        self.isAnimatingView = true
        animationTimer.startTime = Date()
        animationTimer.start()
    }

    private func readAnimationTimer() {
        if animationTimer.isRunning {
            if animationTimer.timerString == "2.0" {
                animationTimer.stop()
                self.isAnimatingView = false
                // TODO: DO SOMETHING
                userBubble.toggleState(state: .active)
                botChibi.toggleActive()
                botBubble.toggleState(state: .inactive)
                vm.nextConversation()
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
