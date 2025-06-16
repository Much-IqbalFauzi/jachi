import Foundation

struct DialogueCardContent: Identifiable {
    let id = UUID()
    var imageName: String
    var progressBarValue: Double
    var textDialogue: String
    var englishTranslation: String?
    
    var isCompleted: Bool {
        progressBarValue >= 1.0
    }
}

let sampleDialogueCards: [DialogueCardContent] = [
    .init(imageName: "Image_Card", progressBarValue: 0.7, textDialogue: "笨蛋", englishTranslation: "Very Smart"),
    .init(imageName: "Image_Card1", progressBarValue: 1.0, textDialogue: "操你吗", englishTranslation: "Thank you"),
    .init(imageName: "Topic Image", progressBarValue: 0.3, textDialogue: "再见", englishTranslation: "Goodbye")
    // Tambah lagi di sini dengan mudah
]
