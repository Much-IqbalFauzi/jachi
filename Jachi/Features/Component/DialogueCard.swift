import SwiftUI

struct DialogueCardView: View {
    
    @State private var textDialogue: String = "Lorem Ipsummm"
    @State private var showDialogue: Bool = false
    @State private var cardImage : Image? = nil
    
    let data : DialogueCardContent
    
    var body: some View {
        VStack(spacing: 0) {
            // Main Card
            ZStack {
                // Card Background with White Border
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.white)
                    .frame(width: 325, height: 154) // Slightly larger for border effect
                
                ZStack {
                    // Full Image Background
                    Image(data.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 321, height: 150)
                        .clipped()
                        .clipShape(RoundedRectangle(cornerRadius: 28))
                    
                    VStack(spacing: 0) {
                        // Top section with completion badge
                        HStack {
                            // Completion Badge (only show if progress is 100%)
                            if data.progressBarValue >= 1.0 {
                                HStack {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(Color(hex : "#3BC0C8"))
                                        .font(.system(size: 7.03))
                                    Text("Completed")
                                        .foregroundColor(Color(hex : "#3BC0C8"))
                                        .font(.system(size: 7.03, weight: .medium))
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(
                                    Capsule()
                                        .fill(Color.white.opacity(0.8))
                                )
                            }
                            Spacer()
                        }
                        .padding(.top, 12)
                        .padding(.leading, 12)
                        
                        Spacer()
                        
                        // Text Overlay Section at Bottom
                        ZStack {
                            // Semi-transparent overlay
                            Rectangle()
                                .fill(Color(hex: "2D969C").opacity(0.9))
                            
                            VStack(spacing: 4) {
                                Text(data.textDialogue)
                                    .foregroundColor(.white)
                                    .font(.system(size: 16, weight: .medium))
                                
                                Text(data.englishTranslation ?? "")
                                    .foregroundColor(.white.opacity(0.8))
                                    .font(.system(size: 12, weight: .regular))
                                    .italic()
                            }
                            .padding(.vertical, 12)
                        }
                        .frame(height: 50)
                        .clipShape(
                            UnevenRoundedRectangle(
                                topLeadingRadius: 0,
                                bottomLeadingRadius: 28,
                                bottomTrailingRadius: 28,
                                topTrailingRadius: 0
                            )
                        )
                    }
                }
                .frame(width: 321, height: 150)
            }
            
            // Progress Bar Section
            VStack(spacing: 10) {
                HStack(spacing : 8) {
                    ProgressView(value: data.progressBarValue)
                        .progressViewStyle(LinearProgressViewStyle())
                        .accentColor(Color(hex: "F5CDE6"))
                        .scaleEffect(x: 1, y: 1.5)
                    Text("\(Int(data.progressBarValue * 100))%")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color(hex: "FFFFFF"))
                }
                .padding(.horizontal, 40)
            }
            .frame(width: 321)
            .padding(.top, 8)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 5)
    }
}

struct DialogueCardContent {
    var imageName : String
    var progressBarValue : Double
    var textDialogue : String
    var englishTranslation: String?
    var isCompleted: Bool {
        return progressBarValue >= 1.0
    }
}

let dialogues : [DialogueCardContent] = [
    DialogueCardContent(
        imageName: "Topic Image",
        progressBarValue: 0.79,
        textDialogue: "买什么",
        englishTranslation: "buying something"
    ),
    DialogueCardContent(
        imageName: "Topic Image",
        progressBarValue: 1.0,
        textDialogue: "买什么",
        englishTranslation: "buying something"
    ),
    DialogueCardContent(
        imageName: "Topic Image",
        progressBarValue: 0.6,
        textDialogue: "你好",
        englishTranslation: "hello"
    ),
    DialogueCardContent(
        imageName: "Topic Image",
        progressBarValue: 0.2,
        textDialogue: "怎么买",
        englishTranslation: "how to buy"
    )
]

#Preview {
    VStack(spacing: 20) {
        DialogueCardView(data: DialogueCardContent(
            imageName: "Topic Image",
            progressBarValue: 0.79,
            textDialogue: "买什么",
            englishTranslation: "buying something"
        ))
        
        DialogueCardView(data: DialogueCardContent(
            imageName: "Topic Image",
            progressBarValue: 1.0,
            textDialogue: "买什么",
            englishTranslation: "buying something"
        ))
    }
    .padding()
    .background(Color(hex: "40C0CB"))
}
