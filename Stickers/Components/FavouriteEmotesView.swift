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
    
    var repoMenu: RepoPages
    
    let column = [
        GridItem(.adaptive(minimum: 45))
    ]
    
    let stickerColumn = [
        GridItem(.adaptive(minimum: 65))
    ]
    
    var body: some View {
        if repoMenu == .emotes {
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
        } else {
            if repoMan.favouriteStickers.count > 0 {
                ContainerView(icon: "star", title: "Favourite Stickers") {
                    LazyVGrid(columns: stickerColumn) {
                        let stickers = repoMan.favouriteStickers
                        
                        ForEach(0..<stickers.count, id: \.self) { i in
                            let sticker = stickers[i]
                            StickerView(stickerURL: sticker)
                        }
                    }
                }
            }
        }
    }
}
