//
//  FrequentlyUsedView.swift
//  Stickers
//
//  Created by Paras KCD on 2022-12-19.
//

import SwiftUI

struct FrequentlyUsedView: View {
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
        ContainerView(icon: "clock.arrow.circlepath", title: "Frequently used") {
            if repoMenu == .emotes {
                if repoMan.frequentlyUsed.count == 0 {
                    Text("Start using Nitroless to show your frequently used emotes here.")
                        .frame(maxWidth: .infinity)
                } else {
                    LazyVGrid(columns: column) {
                        let emotes = repoMan.frequentlyUsed
                        
                        ForEach(0..<emotes.count, id: \.self) { i in
                            let emote = emotes[i]
                            EmoteView(emoteURL: emote)
                        }
                    }
                }
            } else {
                if repoMan.frequentlyUsedStickers.count == 0 {
                    Text("Start using Nitroless to show your frequently used stickers here.")
                        .frame(maxWidth: .infinity)
                } else {
                    LazyVGrid(columns: stickerColumn) {
                        let stickers = repoMan.frequentlyUsedStickers
                        
                        ForEach(0..<stickers.count, id: \.self) { i in
                            let sticker = stickers[i]
                            
                            StickerView(stickerURL: sticker)
                        }
                    }
                }
            }
        }
        .padding(.bottom, 20)
    }
}
