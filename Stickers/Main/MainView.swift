//
//  MainView.swift
//  Stickers
//
//  Created by Paras KCD on 2022-12-19.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var mvc: MessagesViewController
    @EnvironmentObject var repoMan: RepoManager
    
    @Binding var repoMenu: RepoPages
    
    var body: some View {
        ScrollView(showsIndicators: false) {
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
                    .padding(.vertical, 10)
                }
                FavouriteEmotesView(repoMenu: repoMenu)
                FrequentlyUsedView(repoMenu: repoMenu)
            }
        }
        .frame(maxHeight: .infinity)
        .padding(10)
    }
}
