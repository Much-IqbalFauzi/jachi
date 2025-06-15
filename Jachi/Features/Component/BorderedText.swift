//
//  BorderedText.swift
//  Jachi
//
//  Created by Muchamad Iqbal Fauzi on 15/06/25.
//

import SwiftUI

struct BorderedText: View {
    private var text: String
    private var isUser: Bool
    
    init(_ text: String, isUser: Bool = false) {
        self.text = text
        self.isUser = isUser
    }
    
    var body: some View {
        Text(text)
            .font(.system(size: 16, weight: .semibold))
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color.lynxWhite)
            .cornerRadius(16)
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isUser ? Color.dustBlizzard : Color.dustPink, lineWidth: 4)
            }
    }
}
