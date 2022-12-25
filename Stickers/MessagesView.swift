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
    @State var repoMenu: RepoPages = .emotes
    
    init(vc: MessagesViewController) {
        self.vc = vc
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.theme.appPrimaryColor)
        UISegmentedControl.appearance().backgroundColor = UIColor(Color.theme.appBGTertiaryColor)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color.theme.appPrimaryColor)], for: .normal)
    }
    
    var body: some View {
        VStack {
            if repoMan.hasStickers() {
                Picker("RepoPages", selection: $repoMenu) {
                    ForEach(0..<RepoPages.allCases.count, id: \.self) {
                        i in
                        let type = RepoPages.allCases[i]
                        Text(type.rawValue).tag(type)
                    }
                }
                .clipShape(Capsule())
                .overlay(Capsule().strokeBorder(Color.theme.appBGSecondaryColor, lineWidth: 3))
                .pickerStyle(.segmented)
                .padding(.horizontal, 50)
                .padding(.top, 10)
                .padding(.bottom, -10)
            }
            
            if repoMan.hasRepositories() {
                VStack {
                    if repoMan.selectedRepo == nil {
                        MainView(repoMenu: repoMenu)
                    } else {
                        RepoView(repoMenu: repoMenu)
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


