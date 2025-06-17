import SwiftUI

struct DummyScreen: View {
    @EnvironmentObject var navigation: Navigation
    @StateObject private var recognizer = SpeechRecognizer()
    @Environment(\.presentationMode) var presentationMode

    @State private var isListening = false
    @State private var splicedDuration: Float = 2.0

    @State private var currentDialogue = 0
    @State private var attempts = 0
    @State private var dialogueCompleted = false

    let oneTopic: ConvTopic = .topic1
    let twoTopic: ConvTopic = .topic3
    
    @State private var topicActive: ConvTopic
    @State private var activeIdx: Int
    @State private var lastTopic: Bool

    init() {
        _topicActive = State(initialValue: ConvTopic.topic1)
        _activeIdx = State(initialValue: 0)
        _lastTopic = State(initialValue: false)
    }

    var body: some View {
        VStack(spacing: 20) {
            if activeIdx < topicActive.dialogs.count {
                let dialogue = topicActive.dialogs[activeIdx]

                TextBubble(
                    isUser: false,
                    speaker: {},
                    slow: {},
                    translate: {},
                    {
                        if(activeIdx == 0){
                            Text(dialogue.answer.hanzi)
                                .font(.system(size: 24))
                                .fontWeight(.semibold)
                                .frame(
                                    maxWidth: .infinity,
                                    alignment: .leading)
                            Text(dialogue.answer.pinyin)
                                .font(.system(size: 24))
                                .fontWeight(.semibold)
                                .frame(
                                    maxWidth: .infinity,
                                    alignment: .leading)
                        } else {
                            Text(dialogue.question.hanzi)
                                .font(.system(size: 24))
                                .fontWeight(.semibold)
                                .frame(
                                    maxWidth: .infinity,
                                    alignment: .leading)
                            Text(dialogue.question.translate)
                                .font(.system(size: 24))
                                .fontWeight(.semibold)
                                .frame(
                                    maxWidth: .infinity,
                                    alignment: .leading)
                        }
                    })
                
                TextBubble(
                    speaker: {},
                    slow: {},
                    translate: {},
                    {
                        if(activeIdx == 0){
                            Text(dialogue.question.hanzi)
                                .font(.system(size: 24))
                                .fontWeight(.semibold)
                                .frame(
                                    maxWidth: .infinity,
                                    alignment: .leading)
                            Text(dialogue.question.pinyin)
                                .font(.system(size: 24))
                                .fontWeight(.semibold)
                                .frame(
                                    maxWidth: .infinity,
                                    alignment: .leading)
                        } else {
                            if(activeIdx == 0){
                                Text(dialogue.answer.hanzi)
                                    .font(.system(size: 14))
                                    .fontWeight(.semibold)
                                    .frame(
                                        maxWidth: .infinity,
                                        alignment: .leading)
                                Text(dialogue.answer.pinyin)
                                    .font(.system(size: 14))
                                    .fontWeight(.semibold)
                                    .frame(
                                        maxWidth: .infinity,
                                        alignment: .leading)
                            }
                        }
                    })

                Text("🎧 Your Chinese input:")
                    .font(.headline)

                ScrollView {
                    Text(recognizer.transcript)
                        .padding()
                        .multilineTextAlignment(.center)
                }

                Button(action: toggleRecording) {
                    Text(isListening ? "🛑 Stop & Check" : "🎙️ Start Listening")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(isListening ? Color.red : Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                if recognizer.resultCode != -1 {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("📊 Result Code: \(recognizer.resultCode)")
                            .font(.title2)
                            .foregroundColor(
                                recognizer.resultCode == 10000 ? .orange :
                                recognizer.resultCode == 15000 ? .red :
                                .blue
                            )
                        
                        Group {
                            Text("🧠 inputted target: \(topicActive.dialogs[activeIdx].question.highlight)")
                            Text("🧠 inputted wordmark: \(topicActive.dialogs[activeIdx].question.wordMark)")
                        }

                        if recognizer.originalAudioDuration > 0 {
                            Text("🕒 Original Audio Duration: \(String(format: "%.2f", recognizer.originalAudioDuration)) sec")
                            Text("✂️ Spliced Audio Duration: \(String(format: "%.2f", recognizer.splicedAudioDuration)) sec")
                        }

                        Text("🧠 Model Predicted: \(recognizer.predictedClass.isEmpty ? "N/A" : recognizer.predictedClass)")
                    }
                    .padding(.top)
                    .onAppear {
                        if recognizer.resultCode > 0 && recognizer.resultCode < 101 {
                            moveToNextDialogue()
                        }
                    }
                }
            } else {
                Text("对话完成！")
                    .font(.title)

                Button("Restart") {
                    activeIdx = 0
                    lastTopic = true
                }
                .padding()
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Check Pronunciation")
    }

    private func toggleRecording() {
        let dialogue = topicActive.dialogs[activeIdx]
        let target = dialogue.question.highlight
        let wordMark = dialogue.question.wordMark
        print("toggle Recording \(target)")
        
        if isListening {
            let result = recognizer.stopRecordingReal(
                target: target,
                duration: splicedDuration
            )
            if result > 0 && result < 101 {
                moveToNextDialogue()
            }
        } else {
            print(wordMark, target)
            recognizer.startRecordingReal(
                beforeTarget: wordMark,
                target: target,
                duration: splicedDuration
            )
            recognizer.resultCode = -1
            recognizer.originalAudioDuration = 0
            recognizer.predictedClass = ""
        }
        isListening.toggle()
    }

    private func moveToNextDialogue() {
        if activeIdx < topicActive.dialogs.count - 1 {
            activeIdx += 1
        } else {
            activeIdx = 0
            lastTopic.toggle()
        }
    }
}


#Preview {
    DummyScreen()
}
