//
//  PressableIcon.swift
//  Jachi
//
//  Created by Muchamad Iqbal Fauzi on 15/06/25.
//

import SwiftUI

struct PressableIcon: View {
    var icon: String
    var color: Color
    var onPress: () -> Void
    
    var body: some View {
        Button(action: onPress) {
            Image(systemName: icon)
                .frame(width: 32, height: 32)
                .foregroundColor(color)
        }
    }
}
