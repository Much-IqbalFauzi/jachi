//
//  Hint.swift
//  Jachi
//
//  Created by Muchamad Iqbal Fauzi on 16/06/25.
//

import SwiftUI

struct Hint: View {
    
    private var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .font(.system(size: 16, weight: .semibold))
            .padding(.horizontal, 24)
            .padding(.vertical, 8)
            .background(Color.lynxWhite)
            .cornerRadius(16)
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.dustAutumn, lineWidth: 4)
            }
    }
}


#Preview {
    Hint("Hello, World!")
}
