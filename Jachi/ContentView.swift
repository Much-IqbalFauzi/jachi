//
//  ContentView.swift
//  Jachi
//
//  Created by Muchamad Iqbal Fauzi on 12/06/25.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject private var navigation = Navigation()
//    @AppStorage("streak") var streak = 0
    @ObservedObject var streak: StreakObject = .init()
    
    var body: some View {
        NavigationStack(path: $navigation.path) {
            SplashScreen()
                .navigationBarBackButtonHidden(true)
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .main:
                        MainScreen(streak)
                            .navigationBarBackButtonHidden(true)
                    case .dialog(let topic):
                        DialogScreen(topic: topic)
//                            .navigationBarBackButtonHidden(true)
                            .navigationTitle(topic.name)
                    case .dummy:
                        DummyScreen()
                    case .finish:
                        FinishScreen(streak: streak)
                            .navigationBarBackButtonHidden(true)
                    }
                }
        }
        .environmentObject(navigation)
        .preferredColorScheme(.light)
    }
}


class StreakObject: ObservableObject {
    @Published var streak: Int = 0
}
