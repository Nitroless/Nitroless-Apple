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
    
    let column = [
        GridItem(.adaptive(minimum: 45))
    ]
    
    var body: some View {
        ContainerView(icon: "clock.arrow.circlepath", title: "Frequently used emotes") {
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
        }
        .padding(.bottom, 20)
    }
}
