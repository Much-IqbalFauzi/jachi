//
//  BtnCircular.swift
//  Jachi
//
//  Created by Muchamad Iqbal Fauzi on 13/06/25.
//

import SwiftUI

struct BtnCircular: View {
    var icon: String
    var fill: Color = .dustBlizzard
    var color: Color = .whiteGreen
    var action: () -> Void = {}
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .foregroundColor(fill)
                .font(.system(size: 32, weight: .semibold))
        }
        .frame(width: 56, height: 56)
        .background(color)
        .clipShape(Circle())
        .background(
            RoundedRectangle(cornerRadius: 36, style: .circular)
                .stroke(Color.smokeBlue, lineWidth: 12)
        )
    }
}

#Preview {
    BtnCircular(icon: "microphone", action: {})
}
