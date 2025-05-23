//
//  VoiceRecorder.swift
//  ARTest
//
//  Created by Vian Martinez on 22/05/25.
//

import SwiftUI

struct VoiceRecorder: View {
    @Binding var showRecord: Bool
    
    @State private var seconds = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let timerAudio = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State var isRecording = true
    @State private var audioText = ""
    @State private var isAnimating = true
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                HStack{
                    Button(action: {}) {
                        Image(systemName: "trash")
                            .font(.system(size: 25))
                            .foregroundColor(.green)
                    }
                    
                    Spacer()
                    
                    Text(timeString(from:seconds))
                        .font(.system(size: 25))
                        .onReceive(timer){_ in
                            if isRecording{
                                seconds += 1
                            }
                        }
                    
                    Spacer()
                    
                    Text(audioText)
                        .animation(.easeInOut(duration: 0.1))
                        .onReceive(timerAudio) { _ in
                            if isAnimating{
                                audioText.append(".")
                            }
                        }
                        .multilineTextAlignment(.trailing)
                        .lineLimit(1)
                        .frame(width: 200)
                    Spacer()
                }

            }
        }
            .navigationBarTitle(Text("Record"), displayMode: .large)
            .navigationBarItems(trailing:
                                    Button(action: {
                self.showRecord.toggle()
            }) {
                Text("Done").bold()
            })
        }
        
        
}
