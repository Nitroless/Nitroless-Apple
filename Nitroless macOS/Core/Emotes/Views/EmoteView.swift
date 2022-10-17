//
//  EmoteView.swift
//  Nitroless macOS
//
//  Created by Paras KCD on 2022-10-11.
//

import SwiftUI
import SDWebImageSwiftUI

struct EmoteView: View {
    let pasteboard = NSPasteboard.general
    let url: String
    let path: String
    let emote: EmoteElement
    let viewModel: ContentViewModel
    
    var body: some View {
        Button {
            viewModel.showToast = true
            pasteboard.clearContents()
            pasteboard.setString(String("\(url)\(path == "" ? "" : "\(path)/")\(emote.name).\(emote.type)"), forType: NSPasteboard.PasteboardType.string)
            viewModel.addToFrequentlyUsedEmotes(frequentEmote: "\(url)\(path == "" ? "" : "\(path)/")\(emote.name).\(emote.type)")
        } label: {
            WebImage(url: URL(string: "\(url)\(path == "" ? "" : "\(path)/")\(emote.name).\(emote.type)"))
                .resizable()
                .frame(height: 48)
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}
