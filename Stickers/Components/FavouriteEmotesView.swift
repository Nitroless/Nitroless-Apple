//
//  FavouriteEmotesView.swift
//  Stickers
//
//  Created by Paras KCD on 2022-12-22.
//

import SwiftUI

struct FavouriteEmotesView: View {
    @EnvironmentObject var mvc: MessagesViewController
    @EnvironmentObject var repoMan: RepoManager
    
    let column = [
        GridItem(.adaptive(minimum: 45))
    ]
    
    var body: some View {
        if repoMan.favouriteEmotes.count > 0 {
            ContainerView(icon: "star", title: "Favourite Emotes") {
                LazyVGrid(columns: column) {
                    let emotes = repoMan.favouriteEmotes
                    
                    ForEach(0..<emotes.count, id: \.self) { i in
                        let emote = emotes[i]
                        EmoteView(emoteURL: emote)
                    }
                }
            }
        }
    }
}
