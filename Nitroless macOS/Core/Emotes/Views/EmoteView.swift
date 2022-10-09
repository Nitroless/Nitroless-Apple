//
//  EmoteView.swift
//  Nitroless
//
//  Created by Paras KCD on 2022-10-09.
//

import SwiftUI
import SDWebImageSwiftUI
import UniformTypeIdentifiers

struct EmoteView: View {
    @StateObject var viewModel: ContentViewModel
    @State var showToast: Bool
    var emote: EmoteElement
    let pasteboard = NSPasteboard.general
    
    var body: some View {
        if emote.type == .gif {
            VStack {
                AnimatedImage(url: URL(string: "\(viewModel.selectedRepo.url)\(viewModel.selectedRepo.emote.path == "" ? "" : "\(viewModel.selectedRepo.emote.path)/")\(emote.name).\(emote.type)"))
                    .resizable()
                    .frame(width: 48, height: 48)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            }
            .onTapGesture {
                self.showToast = true
                pasteboard.clearContents()
                pasteboard.setString(String("\(viewModel.selectedRepo.url)\(viewModel.selectedRepo.emote.path == "" ? "" : "\(viewModel.selectedRepo.emote.path)/")\(emote.name).\(emote.type)"), forType: NSPasteboard.PasteboardType.string)
            }
        } else {
            VStack {
                WebImage(url: URL(string: "\(viewModel.selectedRepo.url)\(viewModel.selectedRepo.emote.path == "" ? "" : "\(viewModel.selectedRepo.emote.path)/")\(emote.name).\(emote.type)"))
                    .resizable()
                    .frame(width: 48, height: 48)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    
            }
            .onTapGesture {
                self.showToast = true
                pasteboard.clearContents()
                pasteboard.setString(String("\(viewModel.selectedRepo.url)\(viewModel.selectedRepo.emote.path == "" ? "" : "\(viewModel.selectedRepo.emote.path)/")\(emote.name).\(emote.type)"), forType: NSPasteboard.PasteboardType.string)
            }
        }
    }
}
