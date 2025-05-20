//
//  ContentView.swift
//  ARTest
//
//  Created by Vian Martinez on 20/05/25.
//

import SwiftUI
import RealityKit

struct ContentView: View {
    
    @State private var isControlsVisible: Bool = true
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            ARViewContainer()
            ControlView(isControlsVisible: $isControlsVisible)
        }.edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) ->
    
        ARView {
            
            let arView = ARView(frame: .zero)
            
            return arView
            
        }
    
    func updateUIView( _ uiView: ARView, context: Context) {}
    
}

#Preview {
    ContentView()
}
