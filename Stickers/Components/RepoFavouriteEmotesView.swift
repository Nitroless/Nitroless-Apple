//
//  RepoFavouriteEmotesView.swift
//  Stickers
//
//  Created by Paras KCD on 2022-12-22.
//

import SwiftUI

struct RepoFavouriteEmotesView: View {
    @EnvironmentObject var mvc: MessagesViewController
    @EnvironmentObject var repoMan: RepoManager
    
    let column = [
        GridItem(.adaptive(minimum: 45))
    ]
    
    var body: some View {
        ContainerView(icon: "star", title: "Favourite Emotes") {
            LazyVGrid(columns: column) {
                if repoMan.selectedRepo != nil {
                    let emotes = repoMan.selectedRepo!.repo.favouriteEmotes
                    
                    if emotes != nil {
                        ForEach(0..<emotes!.count, id: \.self) {
                            i in
                            let emote = emotes![i]
                            EmoteView(emoteURL: emote)
                        }
                    }
                }
            }
        }
    }
}
