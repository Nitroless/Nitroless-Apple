//
//  BottomBarView.swift
//  Keyboard
//
//  Created by Paras KCD on 2022-11-04.
//

import SwiftUI

struct BottomBarView: View {
    @EnvironmentObject var repoMan: RepoManager
    @EnvironmentObject var kbv: KeyboardViewController
    var showGlobe: Bool
    var repoMenu: RepoPages
    @AppStorage("hideRepoDrawer", store: UserDefaults(suiteName: "group.llsc12.Nitroless")) private var hideRepoDrawer = false
    
    var body: some View {
        HStack {
            if showGlobe {
                kbSwitch(vc: kbv)
                    .frame(width: 30, height: 30)
                    .padding(.leading, 10)
            }
            
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
                    .offset(y: 1)
                    .opacity(repoMan.selectedRepo == nil ? 1 : 0)
            }
            .padding([.top, .horizontal], 5)
            .padding(.leading, showGlobe ? 0 : 10)
            
            Divider()
                .frame(height: 40)
                .offset(y: 4)
        
            if !hideRepoDrawer {
                HStack {
                    
                    if repoMan.repos.isEmpty {
                        ProgressView()
                    } else {
                        if repoMenu == .emotes {
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack {
                                    ForEach(repoMan.repos, id: \.url) { repo in
                                        if repo.repoData != nil {
                                            BottomBarItemView(repo: repo, selectRepo: { repoMan.selectRepo(selectedRepo: SelectedRepo(active: true, repo: repo))}, selectedRepo: repoMan.selectedRepo)
                                        }
                                    }
                                }
                            }
                        } else {
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack {
                                    ForEach(repoMan.repos, id: \.url) { repo in
                                        if repo.repoData != nil && repo.repoData!.stickers != nil &&  repo.repoData!.stickers!.count > 0 {
                                            BottomBarItemView(repo: repo, selectRepo: { repoMan.selectRepo(selectedRepo: SelectedRepo(active: true, repo: repo))}, selectedRepo: repoMan.selectedRepo)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            } else {
                Rectangle().fill(Color.clear)
            }
            
            Divider()
                .frame(height: 40)
                .offset(y: 4)
            
            Button {
                if repoMan.selectedEmote != nil {
                    for _ in 0..<repoMan.selectedEmote!.count {
                        kbv.textDocumentProxy.deleteBackward()
                    }
                }
            } label: {
                Image(systemName: "delete.left")
                    .resizable()
                    .frame(width: 25, height: 20)
                    .foregroundColor(Color.theme.textColor)
            }
            .buttonStyle(.plain)
            .padding([.top, .horizontal], 5)
            .padding(.trailing, 10)
            .offset(y: -2)
        }
    }
}
