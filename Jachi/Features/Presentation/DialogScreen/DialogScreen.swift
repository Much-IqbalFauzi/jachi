//
//  DialogScreen.swift
//  Jachi
//
//  Created by Muchamad Iqbal Fauzi on 12/06/25.
//

import SwiftUI

struct DialogScreen: View {

    @EnvironmentObject var navigation: Navigation
    @StateObject private var vm: DialogViewmodel = .init()

    var body: some View {
        VStack {
            Text("Dialog Screen")
            ExampleButton(
                text: "Back",
                action: {
                    self.navigation.pop()
                })
        }
    }
}

#Preview {
    DialogScreen()
}
