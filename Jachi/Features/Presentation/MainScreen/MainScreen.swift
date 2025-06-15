import SwiftUI

struct MainScreen: View {
    @EnvironmentObject var navigation: Navigation
    @StateObject private var vm: MainScreenViewmodel = .init()

    @State private var streakImage: Image?
    @State private var streakText: String = "5"

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                Image("Background")
                    .ignoresSafeArea(.all)
                VStack(spacing: 0) {
                    ZStack {
                        VStack(spacing: 0) {
                            // Top streak section
                            HStack {
                                Spacer()
                                HStack() {
                                    // Streak emoji/icon
                                    Image("StreakImage")
                                        .frame(width: 42.62, height: 39.98)
                                    
                                    VStack(spacing: 0) {
                                        Text(streakText)
                                            .font(.system(size: 28, weight: .heavy, design: .rounded))
                                            .foregroundColor(Color(hex: "154447"))
                                        Text("Days")
                                            .font(.system(size: 16, weight: .heavy, design: .rounded))
                                            .foregroundColor(Color(hex: "154447"))
                                    }
                                }
                                .padding(.horizontal, 30)
                                .padding(.top,1)
                            }
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Text("Topics")
                                        .font(.system(size: 30, weight: .heavy, design: .rounded))
                                        .foregroundColor(Color(hex: "154447"))
                                    Spacer()
                                }
                                
                                HStack {
                                    Text("Time to upgrade your skills!")
                                        .font(.system(size: 13.5, weight: .medium, design: .rounded))
                                        .foregroundColor(Color(hex: "154447"))
                                    Spacer()
                                }
                                Rectangle()
                                    .fill(Color(hex: "00A99D"))
                                    .frame(height: 1)
                                    .frame(width : 320)
                                    .padding(.top,5)
                            }
                            .padding(.horizontal, 30)
                            .padding(.top, 20)
                            .padding(.bottom, 20)
                        }
                    }
                    // Content/ Card goes here
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 20) {
                            ForEach(sampleDialogueCards) { card in
                                DialogueCardView(data: card)
                            }
                        }
                        .padding(.horizontal, 30)
                        .padding(.bottom, 20)
                    }

                    Spacer()
                }
            }
        }
    }
}


// Unused
//struct CurvedShape: Shape {
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//
//        // Start from top-left
//        path.move(to: CGPoint(x: 0, y: 0))
//
//        // Line to top-right
//        path.addLine(to: CGPoint(x: rect.maxX, y: 0))
//
//        // Line down the right side
//        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - 60))
//
//        // Curved bottom edge
//        path.addQuadCurve(
//            to: CGPoint(x: 0, y: rect.maxY - 60),
//            control: CGPoint(x: rect.midX, y: rect.maxY + 40)
//        )
//
//        // Close the path back to start
//        path.closeSubpath()
//
//        return path
//    }
//}

#Preview {
    MainScreen() // Add this if needed for preview
}
