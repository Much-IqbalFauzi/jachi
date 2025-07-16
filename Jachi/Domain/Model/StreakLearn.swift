//
//  StreakLearn.swift
//  Jachi
//
//  Created by Muchamad Iqbal Fauzi on 02/07/25.
//

import Foundation
import SwiftData

@Model
final class StreakLearn {
    
    var total: Int
    var lastDate: Date
    
    init(total: Int = 0, lastDate: Date = Date()) {
        self.total = total
        self.lastDate = lastDate
    }
}
