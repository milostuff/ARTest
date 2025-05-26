//
//  ARTestApp.swift
//  ARTest
//
//  Created by Vian Martinez on 20/05/25.
//

import SwiftUI

@main
struct ARTestApp: App {
    @StateObject var placementSettings = PlacementSettings()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(placementSettings)
        }
    }
}
