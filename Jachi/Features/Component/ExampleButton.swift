//
//  ExampleButton.swift
//  Jachi
//
//  Created by Muchamad Iqbal Fauzi on 12/06/25.
//

import SwiftUI

struct ExampleButton: View {

    var text: String
    var action: () -> Void = {}

    var body: some View {
        Button(action: action) {
            Text(text)
        }
    }
}

#Preview {
    ExampleButton(text: "Hello")
}
