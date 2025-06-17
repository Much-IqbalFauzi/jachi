//
//  Progress.swift
//  Jachi
//
//  Created by Muchamad Iqbal Fauzi on 17/06/25.
//

import SwiftUI

struct Progress: ProgressViewStyle {

    var color: Color = .dustBlizzard
    var labelFontStyle: Font = .body

    func makeBody(configuration: Configuration) -> some View {

        let progress = configuration.fractionCompleted ?? 0.0

        GeometryReader { geometry in

            VStack(alignment: .leading) {

                configuration.label
                    .font(labelFontStyle)

                RoundedRectangle(cornerRadius: 10.0)
                    .fill(Color.smokeBlue)
                    .frame(height: 10)
                    .frame(width: geometry.size.width)
                    .overlay(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 10.0)
                            .fill(color)
                            .frame(width: geometry.size.width * progress)
                            .overlay {
                                if let currentValueLabel = configuration
                                    .currentValueLabel
                                {

                                    currentValueLabel
                                        .font(.headline)
                                        .foregroundColor(.dustBlizzard)
                                }
                            }
                    }

            }

        }
    }
}

#Preview {
    ProgressView(value: 0.3, label: { Text("") }, currentValueLabel: { Text("30%").padding(.top, -30) })
        .progressViewStyle(Progress())
}
