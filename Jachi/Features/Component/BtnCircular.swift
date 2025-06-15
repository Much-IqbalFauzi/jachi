//
//  BtnCircular.swift
//  Jachi
//
//  Created by Muchamad Iqbal Fauzi on 13/06/25.
//

import SwiftUI

struct BtnCircular: View {
    var icon: String
    var action: () -> Void = {}
    var color: Color = .dustBlizzard
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .foregroundColor(.lynxWhite)
                .font(.system(size: 32, weight: .semibold))
        }
        .frame(width: 76, height: 76)
        .background(color)
        .clipShape(Circle())
        .background(
            RoundedRectangle(cornerRadius: 36, style: .circular)
                .stroke(Color.blizzardBlue, lineWidth: 12)
        )
    }
}

#Preview {
    BtnCircular(icon: "microphone", action: {})
}
