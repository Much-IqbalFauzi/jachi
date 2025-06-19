//
//  SplashScreen.swift
//  Jachi
//
//  Created by Muchamad Iqbal Fauzi on 17/06/25.
//
import SwiftUI

struct SplashScreen: View {
    
    @EnvironmentObject var navigation: Navigation
    
    @State private var dropShadow = false
    @State private var dropCharacter = false
    @State private var dropHat = false
    @State private var showText = false

    var body: some View {
        ZStack {
            Color.cream
                .ignoresSafeArea()

            VStack {
                Spacer()
                
                ZStack {
                    Image("shadow")
                        .offset(y: dropShadow ? 64 : -400)
                        .opacity(dropShadow ? 1 : 0)
                        .animation(.easeOut(duration: 0.5), value: dropShadow)

                    Image("character")
                        .offset(y: dropCharacter ? -16 : -360)
                        .opacity(dropCharacter ? 1 : 0)
                        .animation(.easeOut(duration: 0.5).delay(0.4), value: dropCharacter)
                    
                    Image("hat")
                        .offset(y: dropHat ? -68 : -320)
                        .opacity(dropHat ? 1 : 0)
                        .animation(.interpolatingSpring(stiffness: 90, damping: 10).delay(0.8), value: dropHat)
                }
                .frame(height: 350)
                
                
                // Teks JaChi
                if showText {
                    Text("JaChi")
                        .font(.system(size: 42, weight: .bold))
                        .foregroundColor(Color(red: 0.1, green: 0.3, blue: 0.3))
                        .transition(.opacity)
                        .padding(.top, -68)
                        .animation(.easeIn(duration: 0.5), value: showText)
                }
                
                Spacer()
            }
        }
        .onAppear {
            dropShadow = true

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                dropCharacter = true
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                dropHat = true
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                showText = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                navigation.navigate(to: .main)
            }
        }
    }
}

#Preview {
    SplashScreen()
}
