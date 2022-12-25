//
//  RepoView.swift
//  Stickers
//
//  Created by Paras KCD on 2022-12-22.
//

import SwiftUI

struct RepoView: View {
    @EnvironmentObject var mvc: MessagesViewController
    @EnvironmentObject var repoMan: RepoManager
    
    var repoMenu: RepoPages
    
    let columns = [
        GridItem(.adaptive(minimum: 45))
    ]
    
    let stickerColumns = [
        GridItem(.adaptive(minimum: 65))
    ]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            if repoMan.selectedRepo != nil {
                if repoMenu == .emotes {
                    if repoMan.selectedRepo!.repo.favouriteEmotes != nil && repoMan.selectedRepo!.repo.favouriteEmotes!.count > 0 {
                        RepoFavouriteEmotesView()
                    }
                    if repoMan.selectedRepo!.repo.repoData != nil {
                        RepoEmotesView()
                    }
                } else {
                    if repoMan.selectedRepo!.repo.favouriteStickers != nil && repoMan.selectedRepo!.repo.favouriteStickers!.count > 0 {
                        RepoFavouriteStickersView()
                    }
                    if repoMan.selectedRepo!.repo.repoData != nil {
                        RepoStickersView()
                    }
                }
            }
            
        }
        .frame(maxHeight: .infinity)
        .padding(10)
    }
}
