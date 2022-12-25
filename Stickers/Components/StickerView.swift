//
//  StickerView.swift
//  Stickers
//
//  Created by Paras KCD on 2022-12-25.
//

import SwiftUI
import SDWebImageSwiftUI
import Messages

struct StickerView: View {
    @EnvironmentObject var mvc: MessagesViewController
    @EnvironmentObject var repoMan: RepoManager
    var stickerURL: URL?
    var body: some View {
        if stickerURL != nil {
            Button {
                repoMan.addToFrequentlyUsedStickers(sticker: stickerURL!.absoluteString)
                mvc.submitMessage(emote: stickerURL!)
                if mvc.presentationStyle == .expanded {
                    mvc.requestPresentationStyle(.compact)
                }
            } label: {
                let size: CGFloat = 65
                
                WebImage(url: stickerURL)
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
