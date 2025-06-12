//
//  MainScreen.swift
//  Jachi
//
//  Created by Muchamad Iqbal Fauzi on 12/06/25.
//

import SwiftUI

struct MainScreen: View {
    
    @EnvironmentObject var navigation: Navigation
    @StateObject private var vm: MainScreenViewmodel = .init()
    
    var body: some View {
        VStack {
            Text("Hello, Main Screen")
            ExampleButton(text: "Detail") {
                self.navigation.navigate(to: .dialog)
            }
            ExampleButton(text: "Dummy") {
                self.navigation.navigate(to: .dummy)
            }
        }
    }
}

#Preview {
    MainScreen()
}
