//
//  KeyboardView.swift
//  Keyboard
//
//  Created by Lakhan Lothiyi on 04/10/2022.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

// colors
let discordBgDark = Color(red: 0.2156, green: 0.2235, blue: 0.2431)
let discordBgLight = Color(red: 1, green: 1, blue: 1)

struct KeyboardView: View {
    
    @Environment(\.colorScheme) var cs
    
    var vc: KeyboardViewController
    
    var showGlobe: Bool {
        let bool = vc.needsInputModeSwitchKey
        return bool
    }
    
    @EnvironmentObject var repoMan: RepoManager
    
    var body: some View {
        // kb needs full access
        // thanks emily
        
        VStack {
            if vc.hasFullAccess {
                kb
            } else {
                AskForAccess()
            }
            if showGlobe {
                VStack(alignment: .leading) {
                    kbSwitch(vc: vc)
                        .frame(width: 30, height: 30)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .background {
            Rectangle()
                .foregroundColor(cs == .light ? discordBgLight : discordBgDark)
        }
    }
    
    @ViewBuilder
    var kb: some View {
        ScrollView(.horizontal) {
            HStack {
                let repos = repoMan.repos
                ForEach(0..<repos.count, id: \.self) { i in
                    let repo = repos[i]
                    Text(repo.repoData!.name)
                }
            }
        }
    }
    
    func type(_ str: String) {
        vc.textDocumentProxy.insertText(str)
    }
} //cum

struct AskForAccess: View {
    
    @Environment(\.colorScheme) var cs
    
    var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    @State var show1 = true
    @State var show2 = false
    
    @State var offset: CGFloat = 0
    
    var body: some View {
        HStack {
            if show1 {
                VStack {
                    Text("Heya, Nitroless Keyboard requires full keyboard access.\nSettings > General > Keyboards > Keyboard - Nitroless > Allow Full Access")
                        .padding(10)
                        .background(content: {
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .foregroundColor(cs == .light ? discordBgLight : discordBgDark)
                                .brightness(-0.1)
                                .shadow(radius: 5)
                        })
                        .padding(12)
                        .padding(.vertical)
                        .padding(.horizontal, 5)
                    
                    Button("Why?") {
                        toSecondPage()
                    }
                    .buttonStyle(.bordered)
                    .padding(.bottom, 5)
                }
                .frame(width: width)
            }
            if show2 {
                VStack {
                    Text("We use full access to access networking so we can load repos and emotes. Nothing else happens! Feel free to check the open-source GitHub repo!")
                        .padding(10)
                        .background(content: {
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .foregroundColor(cs == .light ? discordBgLight : discordBgDark)
                                .brightness(-0.1)
                                .shadow(radius: 5)
                        })
                        .padding(12)
                        .padding(.vertical)
                        .padding(.horizontal, 5)
                    
                    Button("Back") {
                        toFirstPage()
                    }
                    .buttonStyle(.bordered)
                    .padding(.bottom, 5)
                }
                .frame(width: width)
            }
        }
        .offset(x: offset)
    }
    
    let idk: CGFloat = -7
    
    func toSecondPage() {
        show1 = true
        show2 = true
        offset = (width - idk) / 2
        
        withAnimation(.spring()) {
            offset.negate()
        }
    }
    
    func toFirstPage() {
        show1 = true
        show2 = true
        offset = ((width - idk) / 2) * -1
        
        withAnimation(.spring()) {
            offset.negate()
        }
        
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
        
        let textColor: UIColor = .lightGray
        button.tintColor = textColor
        return button
    }
    
    func updateUIView(_ uiView: UIButton, context: Context) {
        let textColor: UIColor = .lightGray
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
