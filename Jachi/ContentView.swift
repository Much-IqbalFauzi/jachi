//
//  ContentView.swift
//  Jachi
//
//  Created by Muchamad Iqbal Fauzi on 12/06/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var navigation = Navigation()
    
    var body: some View {
        NavigationStack(path: $navigation.path) {
            MainScreen()
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .main:
                        MainScreen()
                    case .dialog(let topic):
                        DialogScreen(topic: topic)
                            .toolbarBackground(.hidden, for: .navigationBar)
                    case .dummy:
                        DummyScreen()
                    }
                }
        }
        .environmentObject(navigation)
        .preferredColorScheme(.light)
    }
}

