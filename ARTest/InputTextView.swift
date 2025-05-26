//
//  TextSpawner.swift
//  ARTest
//
//  Created by mrvl on 21/05/25.
//

import SwiftUI

func spawnText(showText: Binding<Bool>) {
    showText.wrappedValue.toggle()
}

struct InputTextView: View {
    @Binding var arText: String
    @Binding var scale: Float
    @State private var keyboardHeight: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                
                HStack(spacing: 20) {
                    Button("⬅️ Rotate Left") {
                        ActionManager.shared.actionStream.send(.rotateLeft)
                    }
                    Button("Place Text") {
                        ActionManager.shared.actionStream.send(.place3DModel)
                    }
                    Button("➡️ Rotate Right") {
                        ActionManager.shared.actionStream.send(.rotateRight)
                    }
                }
                .padding()
                .background(Color.white.opacity(0.7))
                .cornerRadius(12)
                
                HStack {
                    Text("Scale: \(String(format: "%.2f", scale))")
                    Slider(value: $scale, in: 0.5...2.0, step: 0.01)
                        .frame(maxWidth: 200)
                }
                .padding(.horizontal)
                
                TextField("Enter AR text", text: $arText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
                
                Spacer()
            }
            .offset(y: -keyboardHeight / 2)
            .frame(width: geometry.size.width, height: geometry.size.height)
            .onAppear {
                // Listen for keyboard changes
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                    if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                        withAnimation {
                            keyboardHeight = keyboardFrame.height
                        }
                    }
                }
                
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                    withAnimation {
                        keyboardHeight = 0
                    }
                }
            }
            .onDisappear {
                NotificationCenter.default.removeObserver(self)
            }
        }
    }
}
