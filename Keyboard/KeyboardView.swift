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
        .background {
            let discordBgDark = Color(red: 0.2156, green: 0.2235, blue: 0.2431)
            let discordBgLight = Color(red: 1, green: 1, blue: 1)
            Rectangle()
                .foregroundColor(cs == .light ? discordBgLight : discordBgDark)
        }
    }
    
    @ViewBuilder
    var kb: some View {
        HStack {
            VStack {
                Text("hi mom")
                    .onTapGesture {
                        vc.textDocumentProxy.insertText("hi mom")
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
                    type(mogus.absoluteString)
                }
        }
    }
    
    @ViewBuilder
    var askForAccess: some View {
        Text("Heya, Nitroless Keyboard requires full keyboard access.\nSettings > General > Keyboards > Keyboard - Nitroless > Allow Full Access")
//            .frame(minHeight: 400)
    }
    
    func type(_ str: String) {
        vc.textDocumentProxy.insertText(str)
    }
}
