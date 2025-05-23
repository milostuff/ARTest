//
//  Utils.swift
//  ARTest
//
//  Created by Vian Martinez on 22/05/25.
//

import Foundation

func timeString(from seconds: Int) -> String {
    let minutes = seconds / 60
    let seconds = seconds % 60
    return String(format: "%02d:%02d", minutes, seconds)
}

enum GestureStates {
    case leftDrag
    case UpwardDrag
    case longPressed
    case noInput
}
