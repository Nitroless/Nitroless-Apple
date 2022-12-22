//
//  RepoEmotesView.swift
//  Stickers
//
//  Created by Paras KCD on 2022-12-22.
//

import SwiftUI

struct RepoEmotesView: View {
    @EnvironmentObject var mvc: MessagesViewController
    @EnvironmentObject var repoMan: RepoManager
    
    let columns = [
        GridItem(.adaptive(minimum: 45))
    ]
    
    var body: some View {
        if repoMan.selectedRepo != nil {
            ContainerView(webImage: repoMan.selectedRepo!.repo.url.appending(path: repoMan.selectedRepo!.repo.repoData!.icon), title: repoMan.selectedRepo!.repo.repoData!.name) {
                LazyVGrid(columns: columns) {
                    let emotes = repoMan.selectedRepo!.repo.repoData!.emotes
                    
                    ForEach(0..<emotes.count, id: \.self) { i in
                        let emote = emotes[i]
                        let emoteURL = repoMan.selectedRepo!.repo.url
                            .appending(path: repoMan.selectedRepo!.repo.repoData!.path)
                            .appending(path: emote.name)
                            .appendingPathExtension(emote.type)
                        EmoteView(emoteURL: emoteURL)
                    }
                }
            }
            .padding(.bottom, 20)
        }
    }
}
