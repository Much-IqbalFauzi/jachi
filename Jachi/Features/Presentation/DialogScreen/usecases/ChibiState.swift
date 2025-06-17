//
//  ChibiState.swift
//  Jachi
//
//  Created by Muchamad Iqbal Fauzi on 17/06/25.
//

import Foundation

class ChibiState: ObservableObject {
    @Published private(set) var state: String = "auntie-normal"
    private var isActive: Bool = true
    private var stateValue: chibiState = .nomal
    
    func changeState(_ newState: chibiState) {
        switch newState {
        case .confused:
            state = isActive ? "auntie-confused" : "auntie-confused-disable"
        case .smile:
            state = isActive ? "auntie-smile" : "auntie-smile-disable"
        case .nomal:
            state = isActive ? "auntie-normal" : "auntie-normal-disable"
        }
    }
    
    func toggleactive() {
        isActive.toggle()
        changeState(stateValue)
    }
}

enum chibiState {
    case nomal
    case smile
    case confused
}
