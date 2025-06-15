//
//  ChatBg.swift
//  Jachi
//
//  Created by Muchamad Iqbal Fauzi on 15/06/25.
//

import SwiftUI

struct ChatBg: View {
    var body: some View {
        GeometryReader { proxy in
            Image("bg_chat")
                .resizable()
                .scaledToFit()
                .frame(width: proxy.size.width, height: proxy.size.height)
                .clipped()
                .blur(radius: 8)
        }.ignoresSafeArea()
    }
}

#Preview {
    ChatBg()
}
