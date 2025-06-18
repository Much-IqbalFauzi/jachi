//
//  Untitled.swift
//  Jachi
//
//  Created by Muchamad Iqbal Fauzi on 13/06/25.
//

import SwiftUI

struct TextBubble<Content: View>: View {

    private var radius: CGFloat
    private var content: () -> Content
    private var isUser: Bool
    private var speaker: () -> Void
    private var slow: () -> Void
    private var piece: () -> Void
    private var isError: Bool
    private var bubbleState: BubbleState
    private var showPiece: Bool

    init(
        bubbleState: BubbleState = .init(),
        isError: Bool = false,
        radius: CGFloat = 16,
        isUser: Bool = true,
        showPiece: Bool = false,
        speaker: @escaping () -> Void,
        slow: @escaping () -> Void,
        piece: @escaping () -> Void,
        @ViewBuilder _ content: @escaping () -> Content
    ) {
        self.radius = radius
        self.content = content
        self.isUser = isUser
        self.speaker = speaker
        self.slow = slow
        self.piece = piece
        self.isError = isError
        self.bubbleState = bubbleState
        self.showPiece = showPiece
    }

    var body: some View {
        VStack(alignment: .leading) {
            content()
            if !isError {
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(bubbleState.primary)
                HStack {
                    PressableIcon(
                        icon: "speaker.wave.2.fill",
                        color: bubbleState.primary,
                        onPress: speaker
                    )
                    PressableIcon(
                        icon: "tortoise",
                        color: bubbleState.primary,
                        onPress: slow
                    )
                    .padding(.horizontal, 10)
                    if showPiece {
                        PressableIcon(
                            icon: "puzzlepiece",
                            color: bubbleState.primary,
                            onPress: piece
                        )
                    }
                }
            }
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity)
        .background(
            UnevenRoundedRectangle(
                topLeadingRadius: radius,
                bottomLeadingRadius: radius,
                bottomTrailingRadius: isUser ? 0 : radius,
                topTrailingRadius: radius,
                style: .continuous
            )
            .stroke(bubbleState.primary, lineWidth: 4)
            .fill(bubbleState.bg)
        )
        .padding(.horizontal, radius)
    }
}

#Preview {
    TextBubble(
        speaker: {},
        slow: {},
        piece: {},
        {

        })
}
