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
    
    @EnvironmentObject var placementSettings: PlacementSettings
    
    //Text Input variables
    @State private var arText: String = "Hello AR!"
    @State private var scale: Float = 1.0

    @State private var showTextInputView: Bool = false
    
    @State private var showBrowse: Bool = false
    @State private var showRecordInputView: Bool = false
    
    @State private var isButtonVisible: Bool = true
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ARViewContainer(text: $arText, scale: $scale)
            if(isButtonVisible){
                ControlView(showText: showTextInputView, showBrowse: showBrowse, showRecord: showRecordInputView)
            }
            
            if(showTextInputView) {
                InputTextView(arText: $arText, scale: $scale)
            }
        }        .onTapGesture {
            isButtonVisible.toggle()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

//#Preview {
//    ContentView()
//}
