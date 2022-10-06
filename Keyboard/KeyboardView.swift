//
//  KeyboardView.swift
//  Keyboard
//
//  Created by Lakhan Lothiyi on 04/10/2022.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct KeyboardView: View {
    
    @Environment(\.colorScheme) var cs
    var vc: KeyboardViewController
    
    lazy var showGlobe: Bool = {
        let bool = vc.needsInputModeSwitchKey
        return bool
    }()
    
    var body: some View {
        // kb needs full access
        // thanks emily
        
        VStack {
            if vc.hasFullAccess {
                kb
            } else {
                askForAccess
            }
        }
        .frame(maxWidth: .infinity)
        .background {
            let discordBgDark = Color(red: 0.2156, green: 0.2235, blue: 0.2431)
            let discordBgLight = Color(red: 1, green: 1, blue: 1)
            Rectangle()
                .foregroundColor(cs == .light ? discordBgLight : discordBgDark)
        }
    }
    
    @State var timer: Timer = Timer()
    @ViewBuilder
    var kb: some View {
        HStack {
            VStack {
                Text("hi mom")
                    .onTapGesture {
                        vc.textDocumentProxy.insertText("\n")
                    }
                
                Button("E") {
                    vc.textDocumentProxy.insertText("E")
                }
                .buttonStyle(.bordered)
            }
            
            let mogus = URL(string: "https://cdn.discordapp.com/emojis/820174282037657620.gif?size=48")!
            WebImage(url: mogus)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .onTapGesture {
                    type("https://cdn.discordapp.com/emojis/820174282037657620.gif?size=48")
                }
        }
    }
    
    @ViewBuilder
    var askForAccess: some View {
        Text("Heya, Nitroless Keyboard requires full keyboard access.\nSettings > General > Keyboards > Keyboard - Nitroless > Allow Full Access")
            .padding()
    }
    
    func type(_ str: String) {
        vc.textDocumentProxy.insertText(str)
    }
}

struct BobbingView<Content: View>: View {
    @State var timer: Timer = Timer()
    @ViewBuilder var content: Content
    @State var bob = false
    
    var body: some View {
        VStack {
            content
                .offset(y: bob ? 10 : -10)
        }
        .onAppear {
            if timer.isValid == false {
                timer = Timer.scheduledTimer(withTimeInterval: 4, repeats: true, block: { _ in
                    withAnimation(.easeInOut(duration: 4)) {
                        bob.toggle()
                    }
                })
            }
        }
    }
    
}
