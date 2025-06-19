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
            SplashScreen()
                .navigationBarBackButtonHidden(true)
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .main:
                        MainScreen()
                            .navigationBarBackButtonHidden(true)
                    case .dialog(let topic):
                        DialogScreen(topic: topic)
//                            .navigationBarBackButtonHidden(true)
                            .navigationTitle(topic.name)
                    case .dummy:
                        DummyScreen()
                    }
                }
        }
        .environmentObject(navigation)
        .preferredColorScheme(.light)
    }
}

