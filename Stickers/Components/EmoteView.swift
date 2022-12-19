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
    
    var emote: URL
    
    var body: some View {
        Button {
            let imageURLString = emote.absoluteString
            let imageCache: SDImageCache = SDImageCache.shared
            let filePath = URL(filePath: imageCache.diskCache.cachePath(forKey: imageURLString)!)
            
            if let conversation = mvc.activeConversation {
                let session = conversation.selectedMessage?.session ?? MSSession()
                let message = MSMessage(session: session)
                let layout = MSMessageTemplateLayout()
                
                layout.image = UIImage(contentsOfFile: filePath.absoluteString)
                message.layout = layout
                conversation.insert(message)
            } else {
                fatalError("Expected a  conversation")
            }
        } label: {
            let size: CGFloat = 40
            
            WebImage(url: emote)
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
