//
//  BottomBarView.swift
//  Keyboard
//
//  Created by Paras KCD on 2022-11-04.
//

import SwiftUI

struct BottomBarView: View {
    @EnvironmentObject var repoMan: RepoManager
    var kbv: KeyboardViewController
    
    var body: some View {
        HStack {
            kbSwitch(vc: kbv)
                .frame(width: 30, height: 30)
                .padding(.leading, 10)
            
            VStack {
                Button {
                    repoMan.selectHome()
                } label: {
                    Image("Icon")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .clipShape(RoundedRectangle(cornerRadius: repoMan.selectedRepo == nil ? 8 : 99, style: .continuous))
                        .shadow(radius: 5)
                }
                Rectangle()
                    .fill(.white)
                    .frame(width: repoMan.selectedRepo == nil ? 32 : 0, height: 3)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .offset(y: 1)
                    .opacity(repoMan.selectedRepo == nil ? 1 : 0)
            }
            .padding([.top, .horizontal], 5)
            
            Divider()
                .frame(height: 40)
                .offset(y: 4)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    if repoMan.repos.isEmpty {
                        Text("Please use the Nitroless App\nto add some Repos")
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(.white))
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background(Color.theme.appBGSecondaryColor)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color(red: 0.29, green: 0.30, blue: 0.33).opacity(0.4), lineWidth: 1))
                            .padding(10)
                    } else {
                        ForEach(repoMan.repos, id: \.url) { repo in
                            if repo.repoData != nil {
                                BottomBarItemView(repo: repo, selectRepo: { repoMan.selectRepo(selectedRepo: SelectedRepo(active: true, repo: repo))}, selectedRepo: repoMan.selectedRepo)
                            }
                        }
                    }
                }
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
            }
            .buttonStyle(.plain)
            .padding([.top, .horizontal], 5)
            .padding(.trailing, 10)
            .offset(y: -2)
        }
    }
}
