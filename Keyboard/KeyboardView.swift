//
//  KeyboardView.swift
//  Keyboard
//
//  Created by Lakhan Lothiyi on 04/10/2022.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI
import Introspect

struct KeyboardView: View {
    
    @Environment(\.colorScheme) var cs
    
    var vc: KeyboardViewController
    
    lazy var showGlobe: Bool = {
        let bool = vc.needsInputModeSwitchKey
        return bool
    }()
    
    @EnvironmentObject var repoMan: RepoManager
    
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
    
    @ViewBuilder
    var kb: some View {
        HStack {
            let repos = repoMan.repos
            ForEach(0..<repos.count, id: \.self) { i in
                let repo = repos[i]
            }
        }
    }
    
    @ViewBuilder
    var askForAccess: some View {
        Text("Heya, Nitroless Keyboard requires full keyboard access.\nSettings > General > Keyboards > Keyboard - Nitroless > Allow Full Access")
            .padding()
            .padding(.bottom)
        
        kbSwitch(vc: vc)
            .frame(width: 30, height: 30)
    }
    
    func type(_ str: String) {
        vc.textDocumentProxy.insertText(str)
    }
}

struct kbSwitch: UIViewRepresentable {
    
    var vc: KeyboardViewController
    
    func makeUIView(context: Context) -> UIButton {
        let button = UIButton()
        let imgConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .large)
        button.setImage(UIImage(systemName: "globe", withConfiguration: imgConfig), for: .normal)
        button.addTarget(self, action: #selector(vc.handleInputModeList(from:with:)), for: .allTouchEvents)
        
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        var textColor: UIColor
        let proxy = vc.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.darkGray
        }
        
        button.tintColor = textColor
        return button
    }
    
    func updateUIView(_ uiView: UIButton, context: Context) {
        var textColor: UIColor
        let proxy = vc.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        
        uiView.tintColor = textColor
    }
    
    typealias UIViewType = UIButton
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

extension View {
    public func introspectButton(customize: @escaping (UIButton) -> ()) -> some View {
        return inject(UIKitIntrospectionView(
            selector: { introspectionView in
                guard let viewHost = Introspect.findViewHost(from: introspectionView) else {
                    return nil
                }
                return Introspect.previousSibling(containing: UIButton.self, from: viewHost)
            },
            customize: customize
        ))
    }
}
