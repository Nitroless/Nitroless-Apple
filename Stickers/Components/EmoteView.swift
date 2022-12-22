//
//  EmoteView.swift
//  Stickers
//
//  Created by Paras KCD on 2022-12-19.
//

import SwiftUI
import SDWebImageSwiftUI
import Messages

struct EmoteView: View {
    @EnvironmentObject var mvc: MessagesViewController
    @EnvironmentObject var repoMan: RepoManager
    
    var emoteURL: URL?
    
    var body: some View {
        if emoteURL != nil {
            Button {
                repoMan.addToFrequentlyUsed(emote: emoteURL!.absoluteString)
                mvc.submitMessage(emote: emoteURL!)
                if mvc.presentationStyle == .expanded {
                    mvc.requestPresentationStyle(.compact)
                }
            } label: {
                let size: CGFloat = 40
                
                WebImage(url: emoteURL)
                    .resizable()
                    .placeholder {
                        ProgressView()
                    }
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size, height: size)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            }
        }
    }
}
