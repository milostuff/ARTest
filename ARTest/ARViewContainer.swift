//
//  ARViewContainer.swift
//  ARTest
//
//  Created by mrvl on 22/05/25.
//

import SwiftUI
import RealityKit

struct ARViewContainer: UIViewRepresentable{
    @Binding var text: String
    @Binding var scale: Float
    
    func makeUIView(context: Context) -> PlaneDetectorARView {
        let view = PlaneDetectorARView()
        view.currentText = text // pass initial text
        return view
    }
    
    func updateUIView(_ uiView: PlaneDetectorARView, context: Context) {
        uiView.currentText = text // keep it in sync
        uiView.updatePlacedTextScale(to: scale)
    }
}
