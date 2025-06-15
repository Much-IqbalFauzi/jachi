import SwiftUI

struct DialogueCardView: View {
    let data: DialogueCardContent
    
    var body: some View {
        VStack(spacing: 0) {
            // Main Card
            ZStack {
                // Card Background with rounded corners
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(hex: "16484B").opacity(1), lineWidth: 1) // Border halus
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(hex : "16484B"))
                    )
                    .frame(width: 321, height: 120)
                    .shadow(color: Color(hex: "ABABAB"), radius: 10, x: 2, y: 60)

                
                VStack(spacing: 0) {
                    // Image Section
                    ZStack {
                        Image(data.imageName)
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
                                    .stroke(Color(hex: "16484B").opacity(1), lineWidth: 1)
                                )
                    }
                    .frame(height: 120)
                    
                    // Bottom Section with Text and Progress
                    VStack(spacing: 0) {
                        // Text Section
                        VStack(spacing: 4) {
                            HStack {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(data.textDialogue)
                                        .foregroundColor(.white)
                                        .font(.system(size: 16, weight: .semibold))
                                    
                                    Text(data.englishTranslation ?? "")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16, weight: .regular))
                                    
                                    if data.progressBarValue >= 1.0 {
                                        HStack(spacing: 4) {
                                            Image(systemName: "checkmark.circle.fill")
                                                .foregroundColor(Color(hex : "CFF5EA"))
                                                .font(.system(size: 15))
                                            Text("Completed")
                                                .foregroundColor(Color(hex : "CFF5EA"))
                                                .font(.system(size: 15, weight: .medium))
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(Color(hex : "CFF5EA"))
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
                        
                        // Progress Bar Section (only show if not completed)
                        if data.progressBarValue < 1.0 {
                            HStack(spacing: 8) {
                                ProgressView(value: data.progressBarValue)
                                    .progressViewStyle(LinearProgressViewStyle())
                                    .accentColor(Color(hex:"CFF5EA"))
                                    .scaleEffect(x: 1, y: 3)
                                
                                Text("\(Int(data.progressBarValue * 100))%")
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundColor(Color(hex:"CFF5EA"))
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color(hex : "CFF5EA"))
                                    .font(.system(size: 14, weight: .semibold))
                            }
                            .padding(.horizontal, 16)
                            .padding(.top, 8)
                            .padding(.bottom, 12)
                        } else {
                            // Add padding for completed cards
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
                        .fill(Color(hex: "16484B"))
                    )
                }
            }
        }
    }
}


#Preview {
    VStack(spacing: 20) {
        DialogueCardView(data: DialogueCardContent(
            imageName: "Image_Card",
            progressBarValue: 0.79,
            textDialogue: "很漂亮",
            englishTranslation: "Sangat Cantik"
        ))
        
        DialogueCardView(data: DialogueCardContent(
            imageName: "Image_Card1",
            progressBarValue: 1.0,
            textDialogue: "我爱你",
            englishTranslation: "Aku sayang Kamu"
        ))
    }
}
