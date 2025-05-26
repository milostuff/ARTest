//
//  PlacementSettings.swift
//  ARTest
//
//  Created by Vian Martinez on 26/05/25.
//

import SwiftUI
import RealityKit
import Combine

class PlacementSettings: ObservableObject {
    
    //When the user selects a model in browseview, this property is set
    @Published var selectedModel: Model? {
        willSet(newValue) {
            print("Setting selectedModel to \(String(describing: newValue?.name))")
        }
    }
    
    
    // When the user taps confirm in PlacementView, the value of selectedModel is assigned to confirmedModel
    @Published var confirmedModel: Model? {
        willSet(newValue) {
            guard let model = newValue else {
                print("Clearing confirmedModel")
                return
            }
            
            print("Setting confirmedModel to \(model.name)")
        }
    }
}
