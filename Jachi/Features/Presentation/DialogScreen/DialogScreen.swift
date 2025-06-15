//
//  DialogScreen.swift
//  Jachi
//
//  Created by Muchamad Iqbal Fauzi on 12/06/25.
//

import Combine
import SwiftUI

struct DialogScreen: View {

    @EnvironmentObject var navigation: Navigation
    @StateObject private var vm: DialogViewmodel
    
    init(topic: ConvTopic) {
        _vm = StateObject(wrappedValue: DialogViewmodel(topic: topic))
    }

    var body: some View {
        GeometryReader { reader in
            VStack(alignment: .trailing) {
                Spacer()
                ScrollView {
                    ForEach(vm.chat, id: \.self) { message in
                        TextBubble(
                            speaker: {},
                            slow: {},
                            translate: {},
                            {
                                Text(message)
                                    .font(.system(size: 24))
                                    .fontWeight(.semibold)
                    //                .multilineTextAlignment(.leading)
                    //                .foregroundColor(.candyFloss)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color.blizzardBlue)
                            })
                    }.rotationEffect(Angle(degrees: 180))
                }
                .rotationEffect(Angle(degrees: -180))
                .frame(width: reader.size.width)
                .frame(maxHeight: reader.size.height / 1.75)
                .background(.white)
                HStack {
                    BtnCircular(
                        icon: "microphone",
                        action: {
                            vm.append("Ni Hao \(vm.chat.count + 1)")
                        })

                }
                .frame(width: reader.size.width)
                .background(.cyan)

            }
            .frame(width: reader.size.width, height: reader.size.height)
        }.background(Color.blizzardBlue)

    }
}

#Preview {
    DialogScreen(topic: .topic1)
}
