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
    private var translate: () -> Void

    init(
        radius: CGFloat = 16,
        isUser: Bool = true,
        speaker: @escaping () -> Void,
        slow: @escaping () -> Void,
        translate: @escaping () -> Void,
        @ViewBuilder _ content: @escaping () -> Content
    ) {
        self.radius = radius
        self.content = content
        self.isUser = isUser
        self.speaker = speaker
        self.slow = slow
        self.translate = translate
    }

    var body: some View {
        VStack(alignment: .leading) {
            content()
            Rectangle()
                .frame(width: .infinity, height: 1)
                .foregroundColor(isUser ? .dustBlizzard : .dustPink)
            HStack(spacing: 10) {
                PressableIcon(
                    icon: "speaker.wave.2",
                    color: isUser ? .dustBlizzard : .dustPink,
                    onPress: speaker
                )
                PressableIcon(
                    icon: "tortoise",
                    color: isUser ? .dustBlizzard : .dustPink,
                    onPress: slow
                )
                .padding(.horizontal, 10)
                PressableIcon(
                    icon: "translate",
                    color: isUser ? .dustBlizzard : .dustPink,
                    onPress: translate
                )
            }
            .frame(width: .infinity)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .foregroundColor(.black)
        .background(
            UnevenRoundedRectangle(
                topLeadingRadius: radius,
                bottomLeadingRadius: radius,
                bottomTrailingRadius: isUser ? 0 : radius,
                topTrailingRadius: radius,
                style: .continuous
            )
            .stroke(isUser ? Color.dustBlizzard : Color.dustPink, lineWidth: 4)
            //            .fill(Color.dustPink)
        )
        .padding(.horizontal, radius)
    }
}

#Preview {
    TextBubble(
        speaker: {},
        slow: {},
        translate: {},
        {

        })
}
