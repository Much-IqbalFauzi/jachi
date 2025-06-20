//
//  DialogScreen.swift
//  Jachi
//
//  Created by Muchamad Iqbal Fauzi on 12/06/25.
//

import AVFAudio
import Combine
import Foundation
import SwiftUI

struct DialogScreen: View {

    @EnvironmentObject var navigation: Navigation
    @StateObject private var vm: DialogViewmodel

    @StateObject private var userBubble: BubbleState = .init()
    @StateObject private var botBubble: BubbleState = .init(
        primary: .dustBlizzard, bg: .smokeGray)

    @StateObject private var botChibi: ChibiState = .init()

    @ObservedObject private var recordTimer: TimerState = .init()
    @ObservedObject private var animationTimer: TimerState = .init()
    @ObservedObject private var dialogTip: TipState = .init()

    @State private var isAnimatingView: Bool = false
    private let duration: Double = 3.0

    let provider = SoundDetectionProvider()

    init(topic: ConvTopic) {
        _vm = StateObject(wrappedValue: DialogViewmodel(topic: topic))
        
    }

    var body: some View {
        ZStack {
            ChatBg()
            GeometryReader { reader in
                VStack(alignment: .center) {
                    HStack(alignment: .center) {
                    }
                    .frame(width: reader.size.width)
                    //                    .padding(.bottom, 16)
                    .padding(.top, 8)
                    .padding(.horizontal, 16)
                    .background(Color.smokeYellow)
                    .scaledToFit()

                    Rectangle()
                        .fill(Color.lightGreen)
                        .frame(height: 5)
                        .frame(
                            width: isAnimatingView ? reader.size.width : 0,
                            alignment: .leading
                        )
                        .animation(
                            .linear(duration: duration),
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
                            //this one
                            TextBubble(
                                bubbleState: botBubble,
                                isError: false,
                                isUser: false,
                                speaker: {
                                    vm.speakutterance(
                                        vm.auntiTalk[vm.auntiIdx].hanzi,
                                        pitch: -4)
                                },
                                slow: {
                                    vm.speakutterance(
                                        vm.auntiTalk[vm.auntiIdx].hanzi,
                                        rate: 0.0001, pitch: -4)
                                },
                                piece: {
                                    vm.speakutterance(
                                        vm.auntiTalk[vm.auntiIdx].highlight,
                                        pitch: -4)
                                },
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
                            isError: false,
                            isUser: true,
                            showPiece: true,
                            speaker: {
                                vm.speakutterance(
                                    vm.userTalk[vm.userIdx].hanzi,
                                    pitch: -4)
                                if vm.isIntroductionShown {
                                    vm.isIntroductionShown = false
                                    dialogTip.toggleChangeTip(.starter, true)
                                }
                                
                            },
                            slow: {
                                vm.speakutterance(
                                    vm.userTalk[vm.userIdx].hanzi, rate: 0.0001,
                                    pitch: -4)
                                if vm.isIntroductionShown {
                                    vm.isIntroductionShown = false
                                    dialogTip.toggleChangeTip(.starter, true)
                                }
                            },
                            piece: {
                                vm.speakutterance(
                                    vm.userTalk[vm.userIdx].highlight,
                                    pitch: -4)
                                if vm.isIntroductionShown {
                                    vm.isIntroductionShown = false
                                    dialogTip.toggleChangeTip(.starter, true)
                                }
                            },
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

                    if dialogTip.isShowTip {
                        Tips({
                            Text(dialogTip.tipText)
                                .multilineTextAlignment(.center)
                        }).padding(.horizontal, 48)
                    }

                    Spacer()
                    Text(stringTimer())
                        .foregroundStyle(Color.lynxWhite)
                        .onReceive(recordTimer.timer) { _ in
                            recordTimer.updateTimerString()
                        }

                    HStack {
                        if vm.btnRecordState == .submit {
                            BtnAction(
                                icon: "trash",
                                fill: .dustBlizzard,
                                action: deleteButtonAction
                            )
                            .padding(.trailing, 20)
                        }

                        BtnCircular(
                            icon: vm.getCurrentRecordState(),
                            fill: vm.isIntroductionShown ? .lightGreen : .dustBlizzard,
                            action: recordButtonAction)
                        .disabled(vm.isIntroductionShown)

                        if vm.btnRecordState == .submit {
                            BtnAction(
                                icon: "speaker.wave.2",
                                fill: .dustBlizzard,
                                action: {
//                                    provider.playSound()
                                }
                            )
                            .padding(.leading, 20)
                            .opacity(0)

                        }

                    }
                    .padding(.top, 8)
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
            dialogTip.toggleChangeTip(.netral, false)
            recordTimer.startTime = Date()
            recordTimer.start()
            vm.btnRecordState = .stop
//            provider.detectionStarted.toggle()
            provider.startDetection(vm.userTalk[vm.userIdx].highlight)
        case .stop:
            recordTimer.stop()
            vm.btnRecordState = .submit
//            provider.detectionStarted.toggle()
            provider.stopDetection()

        case .submit:
            vm.btnRecordState = .record
            if !provider.isFoundSound {
                vm.nextConversation({ isFinish in
                    if isFinish {
                        navigation.navigate(to: .finish)
                    }
                    botChibi.toggleActive()
                    botBubble.toggleState(state: .activeAuntie)
                    userBubble.toggleState(state: .inactive)
                    runAnimationTimer()
                    
                })
            } else {
                vm.totalWrong += 1
                dialogTip.toggleChangeTip(.wrong, true)
            }

            if vm.totalWrong >= 3 {
                vm.btnRecordState = .giveup
                dialogTip.toggleChangeTip(.finish, true)
            }
        case .giveup:
            vm.totalWrong = 0
            vm.nextConversation({ isFinish in
                if (isFinish) {
                    navigation.navigate(to: .finish)
                }
                botChibi.toggleActive()
                botBubble.toggleState(state: .activeAuntie)
                userBubble.toggleState(state: .inactive)
                runAnimationTimer()
//                vm.speakutterance(
//                    vm.auntiTalk[vm.auntiIdx].hanzi,
//                    pitch: -4)
            })
            vm.btnRecordState = .record
        }
    }

    private func deleteButtonAction() {
        vm.btnRecordState = .record
        recordTimer.reset()
        // TODO: ADD SOMETHING TO DELETE AV AUDIO SESSION
    }

    private func stringTimer() -> String {
        return vm.btnRecordState == .stop || vm.btnRecordState == .submit
            ? "Timer: \(recordTimer.timerString)" : ""
    }

    private func runAnimationTimer() {
        self.isAnimatingView = true
        animationTimer.startTime = Date()
        animationTimer.start()
        dialogTip.toggleChangeTip(.right, true)
    }

    private func readAnimationTimer() {
        if animationTimer.isRunning {
            if animationTimer.timerString == String(duration) {
                animationTimer.stop()
                self.isAnimatingView = false
                // TODO: DO SOMETHING
                userBubble.toggleState(state: .active)
                botChibi.toggleActive()
                botBubble.toggleState(state: .inactive)
                vm.nextConversation()

                // TODO: CLOSE TIP
                dialogTip.toggleChangeTip(.netral, false)
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
