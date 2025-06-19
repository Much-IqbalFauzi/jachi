import SwiftUI

struct MainScreen: View {
    @EnvironmentObject var navigation: Navigation

    @State private var streakImage: Image?
    private var streakText: StreakObject
    
    init (_ streak: StreakObject) {
        self.streakText = streak
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                Image("Background")
                    .ignoresSafeArea(.all)
                VStack(spacing: 0) {
                    ZStack {
                        VStack(spacing: 0) {
                            HStack {
                                Spacer()
                                HStack() {
                                    Image("StreakImage")
                                        .frame(width: 42.62, height: 39.98)
                                    
                                    VStack(spacing: 0) {
                                        Text("\(streakText.streak)")
                                            .font(.system(size: 28, weight: .heavy, design: .rounded))
                                            .foregroundColor(Color.darkCyan)
                                        Text("Days")
                                            .font(.system(size: 16, weight: .heavy, design: .rounded))
                                            .foregroundColor(Color.darkCyan)
                                    }
                                }
                                .padding(.horizontal, 30)
                                .padding(.top,1)
                            }
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Text("Topics")
                                        .font(.system(size: 30, weight: .heavy, design: .rounded))
                                        .foregroundColor(Color.darkCyan)
                                    Spacer()
                                }
                                
                                HStack {
                                    Text("Time to upgrade your skills!")
                                        .font(.system(size: 13.5, weight: .medium, design: .rounded))
                                        .foregroundColor(Color.darkCyan)
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
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 20) {
                            ForEach(Array(listOfTopic.enumerated()), id: \.element.id) { index, topic in
                                DialogueCardView(
                                    topic: topic,
                                    topicIndex: index,
                                    onTap: {
                                        print("telah dipencet")
                                        navigation.navigate(to: .dialog(topic: topic))
                                    }
                                )
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

#Preview {
    MainScreen(StreakObject())
        .environmentObject(Navigation())
}
