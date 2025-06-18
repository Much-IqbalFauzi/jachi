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

    @StateObject private var recognizer = SpeechRecognizer()

    @StateObject private var userBubble: BubbleState = .init()
    @StateObject private var botBubble: BubbleState = .init(
        primary: .dustBlizzard, bg: .smokeGray)

    @StateObject private var botChibi: ChibiState = .init()
    @State private var audioPlayer: AVAudioPlayer?
    @State private var isRecording: Bool = false

    @ObservedObject private var recordTimer: TimerState = .init()
    @ObservedObject private var animationTimer: TimerState = .init()
    @ObservedObject private var dialogTip: TipState = .init()

    @State private var isAnimatingView: Bool = false
    private let duration: Double = 5.0

    init(topic: ConvTopic) {
        _vm = StateObject(wrappedValue: DialogViewmodel(topic: topic))
    }

    var body: some View {
        ZStack {
            ChatBg()
            GeometryReader { reader in
                VStack(alignment: .center) {
                    HStack(alignment: .center) {
                        //                        ProgressView(
                        //                            value: 1,
                        //                            label: {},
                        //                            currentValueLabel: {
                        //                                Text("\(vm.progressFormatting())").padding(
                        //                                    .top, -30)
                        //                            }
                        //                        )
                        //                        .progressViewStyle(Progress())
                    }
                    .frame(width: reader.size.width)
                    .padding(.bottom, 16)
                    .padding(.top, 32)
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

                    if dialogTip.isShowTip {
                        Tips({
                            Text(dialogTip.tipText)
                        }).padding(.horizontal, 48)
                    }

                    Spacer()
                    Text(stringTimer())
                        .foregroundStyle(Color.lynxWhite)
                        .onReceive(recordTimer.timer) { _ in
                            recordTimer.updateTimerString()
                        }

                    HStack {
                        //                        Text("Audio URL: \(vm.fullRecordedAudioURL?.absoluteString ?? "nil")")
                        //                        if let url = vm.fullRecordedAudioURL {
                        //                            Button("▶️ Play Recording") {
                        //                                playAudio(from: url)
                        //                            }.padding()
                        //                        }

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
                            fill: .dustBlizzard,
                            action: recordButtonAction)

                        if vm.btnRecordState == .submit {
                            BtnAction(
                                icon: "speaker.wave.2",
                                fill: .dustBlizzard,
                                action: {
                                    playAudio(from: vm.fullRecordedAudioURL!)
                                }
                            )
                            .padding(.leading, 20)

                        }

                        //                        if vm.btnRecordState == .submit{
                        //                            BtnCircular(
                        //                                icon: "x.circle",
                        //                                fill: .dustBlizzard,
                        //                                action: {
                        //                                    vm.totalWrong += 1
                        //                                    dialogTip.toggleChangeTip(.wrong, true)
                        //                                })
                        //                            .padding(.leading, 20)
                        //                        }
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
            recordTimer.startTime = Date()
            recordTimer.start()
            vm.btnRecordState = .stop
            //            toggleRecording()

            vm.startRecordingReal()
        case .stop:
            recordTimer.stop()
            vm.btnRecordState = .submit
            //            toggleRecording()

            vm.stopRecordingReal()
        case .submit:
            vm.btnRecordState = .record
            if vm.totalWrong >= 3 {
                vm.btnRecordState = .giveup
                dialogTip.toggleChangeTip(.wrong, true)
            } else {
                let result = vm.anaylizeReal()
                if result > 0 && result < 101 {
                    vm.nextConversation({ isFinish in
                        if isFinish {
                            navigation.pop()
                        }
                        botChibi.toggleActive()
                        botBubble.toggleState(state: .activeAuntie)
                        userBubble.toggleState(state: .inactive)
                        runAnimationTimer()
                        vm.speakutterance(
                            vm.auntiTalk[vm.auntiIdx].hanzi,
                            pitch: -4)
                    })
                } else {
                    vm.totalWrong += 1
                    dialogTip.toggleChangeTip(.wrong, true)
                }
            }
        //            vm.nextConversation({ isFinish in
        //                if (isFinish) {
        //                    navigation.pop()
        //                }
        //                botChibi.toggleActive()
        //                botBubble.toggleState(state: .activeAuntie)
        //                userBubble.toggleState(state: .inactive)
        //                runAnimationTimer()
        //                vm.speakutterance(
        //                    vm.auntiTalk[vm.auntiIdx].hanzi,
        //                    pitch: -4)
        //            })
        //
        //            recordTimer.reset()

        // TODO: ANALYZE ML

        case .giveup:
            // TODO: Do something
            vm.nextQuestion()
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

    private func toggleRecording() {
        let userTalk = vm.questionn

        if vm.isRecording {
            // Stop recording and process audio
            //            let result = vm.stopRecordingReal(
            //                target: vm.questionn.highlight,
            //                duration: 2.0
            //            )

            //            print("Recording stopped, result: \(result)")

            //            if result > 0 && result < 101 {
            //                vm.nextQuestion()
            //            } else {
            //                vm.totalWrong += 1
            //                dialogTip.toggleChangeTip(.wrong, true)
            //            }
        } else {
            // Start recording (reset state first)
            vm.resultCode = -1
            vm.originalAudioDuration = 0
            vm.predictedClass = ""

            //            vm.startRecordingReal(
            //                beforeTarget: userTalk.wordPrevix,
            //                target: userTalk.highlight,
            //                duration: 2.0
            //            )

            print("Recording started")
        }
    }

    private func readText(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        if let chineseVoice = AVSpeechSynthesisVoice(language: "zh-CN") {
            utterance.voice = chineseVoice
        } else {
            print("⚠️ zh-CN voice not available. Using default voice.")
        }
        utterance.rate = 0.5
        AVSpeechSynthesizer().speak(utterance)
    }

    private func playAudio(from url: URL) {
        // 1. Verify file exists
        guard FileManager.default.fileExists(atPath: url.path) else {
            print("❌ File doesn't exist at path: \(url.path)")
            return
        }

        // 2. Configure audio session
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playback, mode: .default)
            try session.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("❌ Audio session setup failed: \(error.localizedDescription)")
            return
        }

        // 3. Initialize player safely
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()

            // 4. Store reference and play
            self.audioPlayer = player
            DispatchQueue.main.async {
                player.play()
                print("✅ Playing audio successfully")
            }
        } catch {
            print(
                "❌ Player initialization failed: \(error.localizedDescription)")

            // Debug the problematic file
            if let data = try? Data(contentsOf: url) {
                print("File size: \(data.count) bytes")
            } else {
                print("Couldn't read file data")
            }
        }
    }
}

#Preview {
    DialogScreen(topic: .topic1)
}
