//
//  KeyboardSim.swift
//  Nitroless iOS
//
//  Created by Lakhan Lothiyi on 10/11/2022.
//

import SwiftUI



struct KeyboardSim: View {
    
    @State var text = "cock"
    
    var body: some View {
        VStack {
            Spacer();Spacer();Spacer()
            
            Text(text)
                .padding()
                .border(.blue, width: 2)
            Spacer()
            keyboard
                .preferredColorScheme(.dark)
                .frame(height: 300)
        }
    }
    
    @State var keyboardMenu: KeyboardCurrentMenuPages = .emotes
    
    @ViewBuilder
    var keyboard: some View {
        VStack {
            Picker("Keyboard Menu Pages", selection: $keyboardMenu) {
                ForEach(0..<KeyboardCurrentMenuPages.allCases.count, id: \.self) { i in
                    let type = KeyboardCurrentMenuPages.allCases[i]
                    Text(type.rawValue).tag(type)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
//            TextField(<#T##title: StringProtocol##StringProtocol#>, text: <#T##Binding<String>#>)
            
            VStack {
            }
            .frame(maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.theme.appBGColor)
    }
}


enum KeyboardCurrentMenuPages: String, CaseIterable {
    case emotes = "Emotes"
    case stickers = "Stickers"
}

struct KeyboardSim_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardSim()
    }
}
