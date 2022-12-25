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
    
    var repoMenu: RepoPages
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                FavouriteEmotesView(repoMenu: repoMenu)
                FrequentlyUsedView(repoMenu: repoMenu)
            }
        }
        .frame(maxHeight: .infinity)
        .padding(10)
    }
}
