//
//  Tips.swift
//  Jachi
//
//  Created by Muchamad Iqbal Fauzi on 17/06/25.
//

import SwiftUI

struct Tips<Content: View>: View {
    
    
    private var content: () -> Content
    private var radius: CGFloat = 8
    
    init(@ViewBuilder _ content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        VStack {
            Image("persona")
                .resizable()
                .frame(width: 44, height: 44)
            VStack {
                Text("Pro Tip:")
                    .fontWeight(.bold)
                    .padding(.bottom, 8)
                content()
            }
            .padding(.vertical, 4)
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: radius)
                    .stroke(Color.smokeYellow, lineWidth: 4)
                    .fill(Color.autumnYellow)
            )
            .padding(.horizontal, radius)
        }
        
    }
}

#Preview {
    Tips({
        Text("HEY")
    })
}
