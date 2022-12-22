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
    
    let columns = [
        GridItem(.adaptive(minimum: 45))
    ]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            if repoMan.selectedRepo != nil {
                if repoMan.selectedRepo!.repo.favouriteEmotes != nil && repoMan.selectedRepo!.repo.favouriteEmotes!.count > 0 {
                    RepoFavouriteEmotesView()
                }
                if repoMan.selectedRepo!.repo.repoData != nil {
                    RepoEmotesView()
                }
            }
            
        }
        .frame(maxHeight: .infinity)
        .padding(10)
    }
}
