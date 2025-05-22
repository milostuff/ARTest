//
//  PopUpMenu.swift
//  ARTest
//
//  Created by Vian Martinez on 21/05/25.
//

import SwiftUI

struct PopUpMenu: View {
    
    @Binding var showBrowse: Bool
    
    var body: some View {
        HStack {
            MenuItem(showBrowse: $showBrowse)
            Spacer()
        }
    }
}

struct MenuItem: View {
    
    @Binding var showBrowse: Bool
    
    var body: some View {
        HStack {
            ItemFormat(systemIconName: "textformat.alt") {
                print("Text button pressed")
            }.offset(x:100, y: 50)

            Spacer()

            ItemFormat(systemIconName: "microphone.fill") {
                print("Microphone button pressed")
            }

            Spacer()

            ItemFormat(systemIconName: "photo") {
                print("Image/Sticker button pressed")
                self.showBrowse.toggle()
            }.offset(x: -100, y: 50)
                .sheet(isPresented: $showBrowse, content: {
                    BrowseView(showBrowse: $showBrowse)
                        .presentationDetents([.medium, .large])
                })
                        
        }
    }
}

struct ItemFormat: View {
    
    let systemIconName: String
    let action: () -> Void

    var body: some View {
        
        Button(action: {
            self.action()
        }) {
            ZStack {
                Circle()
                    .foregroundColor(.white)
                    .frame(width: 56, height: 56)
                    .shadow(radius: 4)
                
                Image(systemName: systemIconName)
                    .font(.system(size: 20))
                    .foregroundColor(.black)
                    .buttonStyle(PlainButtonStyle())
            }
        }

    }
}






