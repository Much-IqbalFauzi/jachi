import SwiftUI

struct DialogueCardView: View {
    let topic: ConvTopic
    let topicIndex: Int
    let onTap: () -> Void
    
    // Index Porgress, cuma buat awalan
    private var progressValue: Double {
        switch topicIndex {
        case 0: return 0.5
        case 1: return 0.0
        case 2: return 0.0
        default: return 0.0
        }
    }
    
    // Menentukan nama gambar berdasarkan index
    private var imageName: String {
        switch topicIndex {
        case 0: return "Image_Card1"
        case 1: return "Image_Card"
        case 2: return "Topic Image"
        default: return "Image_Card"
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.darkGreen.opacity(1), lineWidth: 1)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.darkGreen)
                    )
                    .frame(width: 321, height: 120)
                    .shadow(color: Color.gray, radius: 10, x: 2, y: 60)

                
                VStack(spacing: 0) {
                    // Image Section
                    ZStack {
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 321, height: 120)
                            .clipped()
                            .clipShape(
                                UnevenRoundedRectangle(
                                    topLeadingRadius: 20,
                                    bottomLeadingRadius: 0,
                                    bottomTrailingRadius: 0,
                                    topTrailingRadius: 20
                                )
                            )
                            //Border gambar
                            .overlay(
                                    UnevenRoundedRectangle(
                                        topLeadingRadius: 20,
                                        bottomLeadingRadius: 0,
                                        bottomTrailingRadius: 0,
                                        topTrailingRadius: 20
                                    )
                                    .stroke(Color.darkGreen.opacity(1), lineWidth: 1)
                                )
                    }
                    .frame(height: 120)
                    
                    VStack(spacing: 0) {
                        VStack(spacing: 4) {
                            HStack {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(topic.hanzi)
                                        .foregroundColor(.white)
                                        .font(.system(size: 16, weight: .semibold))
                                    Text(topic.name)
                                        .foregroundColor(.white)
                                        .font(.system(size: 16, weight: .semibold))
                                    
                                    if progressValue >= 1.0 {
                                        HStack(spacing: 4) {
                                            Image(systemName: "checkmark.circle.fill")
                                                .foregroundColor(Color.lightGreen)
                                                .font(.system(size: 15))
                                            Text("Completed")
                                                .foregroundColor(Color.lightGreen)
                                                .font(.system(size: 15, weight: .medium))
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(Color.lightGreen)
                                                .font(.system(size: 15, weight: .semibold))
                                        }
                                        .padding(.top, 10)
                                    }
                                }
                                
                                Spacer()
                            }
                            .padding(.horizontal, 16)
                            .padding(.top, 12)
                        }
                        
                        // Progress Bar Section (kalau belum 100%)
                        if progressValue < 1.0 {
                            HStack(spacing: 8) {
                                ProgressView(value: progressValue)
                                    .progressViewStyle(LinearProgressViewStyle())
                                    .accentColor(Color.lightGreen)
                                    .scaleEffect(x: 1, y: 3)
                                
                                Text("\(Int(progressValue * 100))%")
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundColor(Color.lightGreen)
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color.lightGreen)
                                    .font(.system(size: 14, weight: .semibold))
                            }
                            .padding(.horizontal, 16)
                            .padding(.top, 8)
                            .padding(.bottom, 12)
                        } else {
                            Spacer()
                                .frame(height: 12)
                        }
                    }
                    .frame(width: 321, height: 120)
                    .background(
                        UnevenRoundedRectangle(
                            topLeadingRadius: 0,
                            bottomLeadingRadius: 20,
                            bottomTrailingRadius: 20,
                            topTrailingRadius: 0
                        )
                        .fill(Color.darkGreen)
                    )
                }
            }
        }
        .onTapGesture {
            onTap()
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        DialogueCardView(
            topic: .topic1,
            topicIndex: 0,
            onTap: { print("Topic 1 tapped") }
        )
        
        DialogueCardView(
            topic: .topic2,
            topicIndex: 1,
            onTap: { print("Topic 2 tapped") }
        )
    }
}
