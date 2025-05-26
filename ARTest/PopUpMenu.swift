//
//  PopUpMenu.swift
//  ARTest
//
//  Created by Vian Martinez on 21/05/25.
//

import SwiftUI

struct PopUpMenu: View {
    
    @Binding var showText: Bool
    @Binding var showBrowse: Bool
    @Binding var showRecord: Bool
    
    var body: some View {
        HStack {
            MenuItem(showText: $showText, showBrowse: $showBrowse, showRecord: $showRecord)
            Spacer()
        }
    }
}

struct MenuItem: View {
    
    @Binding var showText: Bool
    @Binding var showBrowse: Bool
    @Binding var showRecord: Bool
    
    var body: some View {
        HStack {
            ItemFormat(systemIconName: "textformat.alt") {
                print("Text button pressed")
            }.offset(x:100, y: 50)

            Spacer()

            ItemFormat(systemIconName: "microphone.fill") {
                print("Microphone button pressed")
                self.showRecord.toggle()
            }.sheet(isPresented: $showRecord, content: {
                VoiceRecorder(showRecord: $showRecord)
                    .presentationDetents([.medium])
            })

            Spacer()

            ItemFormat(systemIconName: "face.dashed.fill") {
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
                    .font(.system(size: 25))
                    .foregroundColor(.black)
                    .buttonStyle(PlainButtonStyle())
            }
        }

    }
}






