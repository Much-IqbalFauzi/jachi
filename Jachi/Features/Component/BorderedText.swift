//
//  BorderedText.swift
//  Jachi
//
//  Created by Muchamad Iqbal Fauzi on 15/06/25.
//

import SwiftUI

struct BorderedText: View {
    private var text: String
    private var bubbleState: BubbleState
    
    init(_ text: String, bubbleState: BubbleState) {
        self.text = text
        self.bubbleState = bubbleState
    }
    
    var body: some View {
        Text(text)
            .font(.system(size: 16, weight: .semibold))
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .foregroundColor(Color(bubbleState.primary))
            .background(Color(bubbleState.bg))
            .cornerRadius(16)
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color(bubbleState.primary), lineWidth: 4)
            }
    }
}
