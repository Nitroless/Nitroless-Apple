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
    @AppStorage("openAsStickers", store: UserDefaults(suiteName: "group.llsc12.Nitroless")) private var openAsStickers = false
    @State var repoMenu: RepoPages = .emotes
    
    init(vc: MessagesViewController) {
        self.vc = vc
        
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.theme.appPrimaryColor)
        UISegmentedControl.appearance().backgroundColor = UIColor(Color.theme.appBGTertiaryColor)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color.theme.appPrimaryColor)], for: .normal)
        
        self.repoMenu = openAsStickers ? .stickers : .emotes
    }
    
    var body: some View {
        VStack {
            if repoMan.hasRepositories() {
                VStack {
                    if repoMan.selectedRepo == nil {
                        MainView(repoMenu: $repoMenu)
                    } else {
                        RepoView(repoMenu: $repoMenu)
                    }
                    BottomBarView(repoMenu: repoMenu)
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


