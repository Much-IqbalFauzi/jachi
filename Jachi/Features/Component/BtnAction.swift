//
//  BtnAction.swift
//  Jachi
//
//  Created by Muchamad Iqbal Fauzi on 18/06/25.
//

import SwiftUI

struct BtnAction: View {
    var icon: String
    var fill: Color = .dustBlizzard
    var color: Color = .whiteGreen
    var action: () -> Void = {}
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .foregroundColor(fill)
                .font(.system(size: 16, weight: .semibold))
        }
        .frame(width: 32, height: 32)
        .background(color)
        .clipShape(Circle())
        .background(
            RoundedRectangle(cornerRadius: 36, style: .circular)
                .stroke(Color.smokeBlue, lineWidth: 8)
        )
    }
}

#Preview {
    BtnAction(icon: "speaker.wave.2", action: {})
}
