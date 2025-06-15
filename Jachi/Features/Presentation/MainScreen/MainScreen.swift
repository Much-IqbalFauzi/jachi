import SwiftUI

struct MainScreen: View {

    @EnvironmentObject var navigation: Navigation
    @StateObject private var vm: MainScreenViewmodel = .init()

    @State private var streakImage: Image?
    @State private var streakText: String = "0"
    @State private var scrollOffset: CGFloat = 0

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                VStack(spacing: 0) {
                    VStack {
                        Text("Your Learning Streak")
                            .font(.system(size: 24, weight: .regular, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(Color(hex: "00A99D"))
                            .padding(.top, 20)
                        
                        Image("Group 7")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 202.26, height: 177.66)
                            .foregroundColor(Color.yellow)
                            .padding(.vertical, 20)
                        
                        Text(streakText + " Days")
                            .font(.system(size: 24, weight: .regular, design: .rounded))
                            .fontWeight(.heavy)
                            .foregroundColor(Color(hex: "00A99D"))
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "F8F8F0"))
                    
                    Spacer()
                }
                .background(Color(hex: "F8F8F0"))
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 100) {
                        Color.clear
                            .frame(height: 300)
                        
                        VStack(spacing: 0) {
                            Text("Topics")
                                .font(.system(size: 25.2, weight: .regular, design: .rounded))
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                                .padding(.top, 30)
                                .padding(.bottom, 15)
                            
                            LazyVStack(spacing: 15) {
                                ForEach(0..<dialogues.count, id: \.self) { index in
                                    DialogueCardView(data: dialogues[index])
                                }
                                
                                ForEach(3..<10) { index in
                                    DialogueCardView(data: DialogueCardContent(
                                        imageName: "Topic Image",
                                        progressBarValue: Double.random(in: 0.1...1.0),
                                        textDialogue: "Sample \(index + 1)"
                                    ))
                                }
                            }
                            .padding(.horizontal)
                            .padding(.bottom, 20)
                            
                            // Add some bottom padding to ensure scrolling works properly
                            Color.clear
                                .frame(height: 50)
                        }
                        .background(
                            CurvedShape()
                                .fill(Color(hex: "40C0CB"))
                        )
                        .frame(maxWidth: .infinity)
                        // Remove the problematic minHeight constraint
                    }
                }
                .background(Color.clear)
                .ignoresSafeArea(.all)
            }
        }
        .background(Color(hex: "F8F8F0").edgesIgnoringSafeArea(.all))
    }
}

struct CurvedShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Start from bottom-left
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        
        // Add line to top-left of the curve start
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + 50))
        
        // Add curve to top-right
        path.addQuadCurve(
                   to: CGPoint(x: rect.maxX, y: rect.minY + 50),
                   control: CGPoint(x: rect.midX, y: rect.minY - 50)
               )
        
        // Add line to bottom-right
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        
        // Close the path
        path.closeSubpath()
        return path
    }
}

#Preview {
    MainScreen()
}
