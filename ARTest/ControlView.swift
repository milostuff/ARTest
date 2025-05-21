//
//  ControlView.swift
//  ARTest
//
//  Created by Vian Martinez on 20/05/25.
//

import SwiftUI

struct ControlView: View {
    
    var body: some View {
        VStack {
            Spacer()
        
            ControlButtonBar()
        }
    }
}


struct TabAddMediaIcon: View {
    
    @Binding var showMenu: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.white)
                .frame(width: 56, height: 56)
                .shadow(radius: 4)

            
            Image(systemName: "plus.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .rotationEffect(Angle(degrees: showMenu ? 45 : 0))
                
        }
    }
}

struct ControlButtonBar: View {
    
    @State private var showMenu = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            HStack {
                
                TabAddMediaIcon(showMenu: $showMenu)
                    .onTapGesture {
                        withAnimation {
                            showMenu.toggle()
                        }
                    }
                
            }
            .frame(height: UIScreen.main.bounds.height / 8)
            .frame(maxWidth: .infinity)
            .padding(30)
            
            if showMenu {
                PopUpMenu()
                    .padding(.bottom, 144)
            }
        }
    }
}
