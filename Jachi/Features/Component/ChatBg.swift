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
            Image("BG-2")
                .resizable()
                .scaledToFill()
                .frame(width: proxy.size.width, height: proxy.size.height)
                .clipped()
                .blur(radius: 2)
//                .opacity(0.5)
        }.ignoresSafeArea()
    }
}

#Preview {
    ChatBg()
}
