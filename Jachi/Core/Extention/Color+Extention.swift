//
//  Color+Extention.swift
//  Jachi
//
//  Created by Muchamad Iqbal Fauzi on 12/06/25.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}


// ADD Color pallete
extension Color {
    static let crimson = Color(hex: "#DC143C") // red
    static let candyFloss = Color(hex: "#EFA8E4") // light pink
    static let cherryPearl = Color(hex: "#F8E1F4") // more more light pink
    static let lynxWhite = Color(hex: "#F7F7F7") // white
    static let blizzardBlue = Color(hex: "#92C5C7") // light blue
    static let smokeBlue = Color(hex: "#CFF5EA") // super light blue
    static let dustPink = Color(hex: "#923F9D") // dark pink
    static let dustBlizzard = Color(hex: "#16484B") // dark blue
    static let autumnYellow = Color(hex: "#FDFAB3") // yellow
    static let darkCyan = Color(hex:"154447") // dark cyan, lebih ke hijau gelap sih
    static let lightGreen = Color(hex:"CFF5EA") //light green
    static let darkGreen = Color(hex:"16484B") //dark green
    static let gray = Color(hex:"ABABAB")
    static let dustAutumn = Color(hex: "#c2bc2f") // dark yellow
    static let smokeGray = Color(hex: "#ADBCC8") // gray
    static let dustGray = Color(hex: "#93A0AB") // gray
    static let oceanBlue = Color(hex: "#1B3B5D")
    static let smokeYellow = Color(hex: "#FFF8DB")
    static let whiteGreen = Color(hex: "#92C5C7")
    static let CyanLowopacity = Color(hex: "#87D0C3")//cyan yang dipake buat volume kalau disabled
    static let cream = Color(hex: "#FFFBE9")

}
