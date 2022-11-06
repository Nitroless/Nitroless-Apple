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
    var vc: KeyboardViewController
    
    var showGlobe: Bool {
        let bool = vc.needsInputModeSwitchKey
        return bool
    }
    
    @StateObject var repoMan: RepoManager = RepoManager()
    
    var body: some View {
        VStack {
            if vc.hasFullAccess {
                if repoMan.hasRepositories() {
                    kb
                } else {
                    AddReposPrompt(vc: vc)
                }
            } else {
                AskForAccess(vc: vc)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 360)
        .background(Color.theme.appBGColor)
    }
    
    @ViewBuilder
    var kb: some View {
        VStack {
            if repoMan.selectedRepo == nil {
                MainView()
            } else {
                RepoView()
            }
            BottomBarView(showGlobe: showGlobe)
        }
        .environmentObject(repoMan)
        .environmentObject(vc)
        .task {
            print("[Nitroless KB] \(repoMan.repos.debugDescription)")
        }
    }
}

struct AddReposPrompt: View {
    
    var vc: KeyboardViewController
    
    var width: CGFloat {
        return UIScreen.main.bounds.width
    }
        
    var body: some View {
        VStack {
            ScrollView {
                Text("You have no repositories available, please add some in the app.")
                    .padding(.bottom, 20)
            }
            .padding([.top, .leading, .trailing], 20)
            .background(Color.theme.appBGSecondaryColor)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(red: 0.29, green: 0.30, blue: 0.33).opacity(0.4), lineWidth: 1))
            
            Button {
                openParentApp()
            } label: {
                Text("Open Nitroless")
                    .foregroundColor(Color(.white))
                    .padding(10)
                    .background(Color.theme.appPrimaryColor)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .shadow(radius: 5)
            }
            .buttonStyle(.plain)
            .padding(.bottom, 5)
        }
        .overlay(alignment: .bottomLeading, content: {
            if vc.needsInputModeSwitchKey {
                kbSwitch(vc: vc)
                    .frame(width: 30, height: 30)
                    .padding(.leading, 10)
            }
        })
    }
    
    func openParentApp() {
        let url = URL(string: "nitroless://")!
        openURL(url: url as NSURL)
    }
    
    
    func openURL(url: NSURL) {
        guard let application = try? self.sharedApplication() else { return }
        application.performSelector(inBackground: "openURL:", with: url)
    }

    func sharedApplication() throws -> UIApplication {
        var responder: UIResponder? = vc
        while responder != nil {
            if let application = responder as? UIApplication {
                return application
            }

            responder = responder?.next
        }

        throw NSError(domain: "UIInputViewController+sharedApplication.swift", code: 1, userInfo: nil)
    }
}

struct AskForAccess: View {
    
    var vc: KeyboardViewController
    
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
                    ScrollView {
                        Text("Heya! To use the Nitroless Keyboard you will require to give it Full Keyboard Access.\nSettings > General > Keyboards > Keyboard - Nitroless > Allow Full Access")
                            .padding(.bottom, 20)
                    }
                    .padding([.top, .leading, .trailing], 20)
                    .background(Color.theme.appBGSecondaryColor)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color(red: 0.29, green: 0.30, blue: 0.33).opacity(0.4), lineWidth: 1))
                    
                    Button {
                        toSecondPage()
                    } label: {
                        Text("Why?")
                            .foregroundColor(Color(.white))
                            .padding(10)
                            .background(Color.theme.appPrimaryColor)
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                            .shadow(radius: 5)
                    }
                    .buttonStyle(.plain)
                    .padding(.bottom, 5)
                }
                .overlay(alignment: .bottomLeading, content: {
                    if vc.needsInputModeSwitchKey {
                        kbSwitch(vc: vc)
                            .frame(width: 30, height: 30)
                            .padding(.leading, 10)
                    }
                })
                .frame(width: width)
            }
            if show2 {
                VStack {
                    ScrollView {
                        Text("Full Access allows the Keyboard to access the internet so we can load the repos and emotes. Nothing else happens! Feel free to check our Open-Source GitHub Repo.")
                            .padding(.bottom, 20)
                    }
                    .padding([.top, .leading, .trailing], 20)
                    .background(Color.theme.appBGSecondaryColor)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color(red: 0.29, green: 0.30, blue: 0.33).opacity(0.4), lineWidth: 1))
                    
                    Button {
                        toFirstPage()
                    } label: {
                        Text("Back")
                            .foregroundColor(Color(.white))
                            .padding(10)
                            .background(Color.theme.appPrimaryColor)
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                            .shadow(radius: 5)
                    }
                    .buttonStyle(.plain)
                    .padding(.bottom, 5)
                }
                .overlay(alignment: .bottomLeading, content: {
                    if vc.needsInputModeSwitchKey {
                        kbSwitch(vc: vc)
                            .frame(width: 30, height: 30)
                            .padding(.leading, 10)
                    }
                })
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
        
        let textColor: UIColor = .white
        button.tintColor = textColor
        return button
    }
    
    func updateUIView(_ uiView: UIButton, context: Context) {
        let textColor: UIColor = .white
        uiView.tintColor = textColor
    }
    
    typealias UIViewType = UIButton
}
