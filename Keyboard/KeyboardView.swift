//
//  KeyboardView.swift
//  Keyboard
//
//  Created by Lakhan Lothiyi on 04/10/2022.
//

import Foundation
import SwiftUI

struct KeyboardView: View {
    var vc: KeyboardViewController
    
    lazy var showGlobe: Bool = {
        let bool = vc.needsInputModeSwitchKey
        return bool
    }()
    
    var body: some View {
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
    }
}
