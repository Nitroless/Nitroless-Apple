//
//  RepoStickersView.swift
//  Stickers
//
//  Created by Paras KCD on 2022-12-25.
//

import SwiftUI

struct RepoStickersView: View {
    @EnvironmentObject var mvc: MessagesViewController
    @EnvironmentObject var repoMan: RepoManager
    
    let columns = [
        GridItem(.adaptive(minimum: 65))
    ]
    
    var body: some View {
        if repoMan.selectedRepo != nil {
            ContainerView(webImage: repoMan.selectedRepo!.repo.url.appending(path: repoMan.selectedRepo!.repo.repoData!.icon), title: repoMan.selectedRepo!.repo.repoData!.name) {
                LazyVGrid(columns: columns) {
                    let stickers = repoMan.selectedRepo!.repo.repoData!.stickers
                    if stickers != nil {
                        ForEach(0..<stickers!.count, id: \.self) { i in
                            let sticker = stickers![i]
                            
                            let stickerURL = repoMan.selectedRepo!.repo.url.appending(path: repoMan.selectedRepo!.repo.repoData!.stickerPath!).appending(path: sticker.name).appendingPathExtension(sticker.type)
                            
                            StickerView(stickerURL: stickerURL)
                        }
                    }
                }
            }
            .padding(.bottom, 20)
        }
    }
}
