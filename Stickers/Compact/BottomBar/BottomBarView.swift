//
//  BottomBarView.swift
//  Stickers
//
//  Created by Paras KCD on 2022-12-19.
//

import SwiftUI

struct BottomBarView: View {
    @EnvironmentObject var mvc: MessagesViewController
    @EnvironmentObject var repoMan: RepoManager
    
    var body: some View {
        HStack {
            VStack {
                Button {
                    repoMan.selectHome()
                } label: {
                    Image("Icon")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .clipShape(RoundedRectangle(cornerRadius: repoMan.selectedRepo == nil ? 8 : 99, style: .continuous))
                        .shadow(radius: 5)
                }
                Rectangle()
                    .fill(Color.theme.textColor)
                    .frame(width: repoMan.selectedRepo == nil ? 28 : 0, height: 3)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .opacity(repoMan.selectedRepo == nil ? 1 : 0)
            }
            .padding(.horizontal, 5)
            .padding(.leading, 10)
            
            Divider()
                .frame(height: 40)
                .offset(y: 4)
            
            if repoMan.repos.isEmpty {
                ProgressView()
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    
                }
            }
            
            Divider()
                .frame(height: 40)
                .offset(y: 4)
            
            VStack {
                Button {
                    openParentApp()
                } label: {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.white)
                }
                .buttonStyle(.plain)
                .frame(width: 28, height: 28)
                .background(Color.theme.appSuccessColor)
                .clipShape(Circle())
                .shadow(radius: 5)
                
                Rectangle()
                    .fill(.clear)
                    .frame(width: 28, height: 3)
                    .offset(y: 1)
                    .opacity(0)
            }
            .padding(.horizontal, 5)
            .padding(.trailing, 10)
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
        var responder: UIResponder? = mvc
        while responder != nil {
            if let application = responder as? UIApplication {
                return application
            }

            responder = responder?.next
        }

        throw NSError(domain: "UIInputViewController+sharedApplication.swift", code: 1, userInfo: nil)
    }
}
