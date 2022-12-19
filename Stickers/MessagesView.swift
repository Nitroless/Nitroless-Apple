//
//  SwiftUIView.swift
//  Stickers
//
//  Created by Paras KCD on 2022-12-19.
//

import SwiftUI

struct MessagesView: View {
    var vc: MessagesViewController
    @StateObject var repoMan: RepoManager = RepoManager()
    
    var body: some View {
        VStack {
            if repoMan.hasRepositories() {
                VStack {
                    if repoMan.selectedRepo == nil {
                        MainView()
                    }
                    BottomBarView()
                }
                .environmentObject(repoMan)
                .environmentObject(vc)
            } else {
                AddReposPrompt(vc: vc)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("AppBGColor"))
    }
}

struct AddReposPrompt: View {
    
    var vc: MessagesViewController
    
    var width: CGFloat {
        return UIScreen.main.bounds.width
    }
        
    var body: some View {
        VStack {
            Text("You have no repositories available, please add some in the app.")
            .padding(20)
            .background(Color.theme.appBGSecondaryColor)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(Color.theme.appBGTertiaryColor.opacity(0.2), lineWidth: 1))
            
            Button {
                openParentApp()
            } label: {
                Text("Open Nitroless")
                    .foregroundColor(Color(.white))
                    .padding(10)
                    .background(Color.theme.appPrimaryColor)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .shadow(radius: 5)
                    .padding(20)
            }
            .buttonStyle(.plain)
            .padding(.bottom, 5)
        }
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
