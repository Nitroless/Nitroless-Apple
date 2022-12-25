//
//  RepoFavouriteStickersView.swift
//  Stickers
//
//  Created by Paras KCD on 2022-12-25.
//

import SwiftUI

struct RepoFavouriteStickersView: View {
    @EnvironmentObject var mvc: MessagesViewController
    @EnvironmentObject var repoMan: RepoManager
    
    let column = [
        GridItem(.adaptive(minimum: 65))
    ]
    
    var body: some View {
        ContainerView(icon: "star", title: "Favourite Stickers") {
            LazyVGrid(columns: column) {
                if repoMan.selectedRepo != nil {
                    let stickers = repoMan.selectedRepo!.repo.favouriteStickers
                    
                    if stickers != nil {
                        ForEach(0..<stickers!.count, id: \.self) {
                            i in
                            let sticker = stickers![i]
                            StickerView(stickerURL: sticker)
                        }
                    }
                }
            }
        }
    }
}
