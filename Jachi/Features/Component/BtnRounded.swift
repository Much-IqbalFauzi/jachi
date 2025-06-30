//
//  BtnRounded.swift
//  Jachi
//
//  Created by Muchamad Iqbal Fauzi on 29/06/25.
//

import SwiftUI

struct BtnRounded: View {
    var text: String
    var trailingIcon: String = "figure.run"
    var btnColor: Color = .smokeBlue
    var foregroundColor: Color = .dustBlizzard
    var action: () -> Void = {}
    
    var body: some View {
        Button(action: action) {
            VStack{
                Label(text, systemImage: trailingIcon)
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                    .foregroundStyle(foregroundColor)
                .padding()
                .frame(maxWidth: 300, maxHeight: 65)
                .foregroundColor(.black)
                .background(btnColor)
                .cornerRadius(15)
                .background(
                    RoundedRectangle(cornerRadius: 18, style: .continuous)
                        .fill(
                            .shadow(
                                .inner(
                                    color: .dustGray,
                                    radius: 0.5,
                                    x: -1,
                                    y: 1
                                )
                            )
                        )
                        .foregroundStyle(btnColor)
                )

            }
            .shadow(color: .gray.opacity(0.5), radius: 3, y: 2)
        }
    }
}
