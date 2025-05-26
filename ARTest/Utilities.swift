//
//  Utilities.swift
//  ARTest
//
//  Created by mrvl on 22/05/25.
//

import Combine

enum Actions {
    case place3DModel
    case rotateLeft
    case rotateRight
}

class ActionManager {
    static let shared = ActionManager()
    
    private init() { }
    
    var actionStream = PassthroughSubject<Actions, Never>()
}
