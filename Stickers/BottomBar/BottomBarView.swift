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
    
    var repoMenu: RepoPages
    
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
            .animation(.spring(), value: repoMan.selectedRepo == nil)
            
            Divider()
                .frame(height: 40)
                .offset(y: 4)
            
            if repoMan.repos.isEmpty {
                ProgressView()
            } else {
                if repoMenu == .emotes {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(repoMan.repos, id: \.url) {
                                repo in
                                if repo.repoData != nil {
                                    BottomBarElementView(
                                        buttonAction: {
                                            repoMan.selectRepo(selectedRepo: SelectedRepo(active: true, repo: repo))
                                        },
                                        webImage: repo.url.appending(path: repo.repoData!.icon),
                                        repo: repo
                                    )
                                }
                            }
                        }
                    }
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(repoMan.repos, id: \.url) {
                                repo in
                                if repo.repoData != nil && repo.repoData!.stickers != nil &&  repo.repoData!.stickers!.count > 0 {
                                    BottomBarElementView(
                                        buttonAction: {
                                            repoMan.selectRepo(selectedRepo: SelectedRepo(active: true, repo: repo))
                                        },
                                        webImage: repo.url.appending(path: repo.repoData!.icon),
                                        repo: repo
                                    )
                                }
                            }
                        }
                    }
                }
            }
            
            Divider()
                .frame(height: 40)
                .offset(y: 4)
            
            VStack {
                Button {
                    openCommunityRepos()
                } label: {
                    Image(systemName: "globe")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.white)
                }
                .buttonStyle(.plain)
                .frame(width: 28, height: 28)
                .background(Color.theme.appPrimaryColor)
                .clipShape(Circle())
                .shadow(radius: 5)
                
                Rectangle()
                    .fill(.clear)
                    .frame(width: 28, height: 3)
                    .offset(y: 1)
                    .opacity(0)
            }
            .padding(.horizontal, 5)
            
            VStack {
                Button {
                    addRepository()
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
        .frame(height: 50)
    }
    
    func openCommunityRepos() {
        let url = URL(string: "nitroless://open-community-repos")!
        openURL(url: url as NSURL)
    }
    
    func addRepository() {
        let url = URL(string: "nitroless://add-repository?url=")!
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
