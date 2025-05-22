//
//  ContentView.swift
//  ARTest
//
//  Created by Vian Martinez on 20/05/25.
//

import SwiftUI
import RealityKit
import ARKit
import FocusEntity
import Combine

struct ContentView: View {
    //Text Input variables
    @State private var arText: String = "Hello AR!"
    @State private var scale: Float = 1.0

    @State private var showTextInputView: Bool = false
    
    @State private var isButtonVisible: Bool = true
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ARViewContainer(text: $arText, scale: $scale)
            if(isButtonVisible){
                ControlView(showText: $showTextInputView)
            }
            
            if(showTextInputView) {
                InputTextView(arText: $arText, scale: $scale)
            }
        }
        .onTapGesture {
            isButtonVisible.toggle()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

//#Preview {
//    ContentView()
//}
