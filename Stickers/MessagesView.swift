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
                    } else {
                        RepoView()
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


