//
//  HomeChildView.swift
//  Nitroless macOS
//
//  Created by Paras KCD on 2022-10-10.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeChildView: View {
    @StateObject var viewModel: ContentViewModel
    let pasteboard = NSPasteboard.general
    
    var body: some View {
        VStack {
            if !viewModel.favouriteEmotes.isEmpty {
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "star")
                        Text("Favourite Emotes")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .font(.headline)
                    
                    Spacer()
                    
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 35))]) {
                        ForEach (viewModel.favouriteEmotes, id: \.self) {
                            emote in
                            Button {
                                viewModel.showToast = true
                                pasteboard.clearContents()
                                pasteboard.setString(emote, forType: NSPasteboard.PasteboardType.string)
                                viewModel.addToFrequentlyUsedEmotes(frequentEmote: emote)
                            } label: {
                                WebImage(url: URL(string: emote))
                                    .resizable()
                                    .placeholder {
                                        ProgressView()
                                    }
                                    .scaledToFit()
                                    .frame(width: 32,height: 32)
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(20)
                .background(Color.theme.appBGSecondaryColor.opacity(0.6))
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(red: 0.29, green: 0.30, blue: 0.33).opacity(0.4), lineWidth: 1)
                    )
            }
            
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "clock.arrow.circlepath")
                    Text("Frequently used emotes")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .font(.headline)
                
                Spacer()
                
                if viewModel.frequentlyUsedEmotes.isEmpty {
                    Text("Start using Nitroless to show your frequently used emotes here.")
                } else {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 35))]) {
                        ForEach (viewModel.frequentlyUsedEmotes, id: \.self) {
                            emote in
                            Button {
                                viewModel.showToast = true
                                pasteboard.clearContents()
                                pasteboard.setString(emote, forType: NSPasteboard.PasteboardType.string)
                                viewModel.addToFrequentlyUsedEmotes(frequentEmote: emote)
                            } label: {
                                WebImage(url: URL(string: emote))
                                    .resizable()
                                    .placeholder {
                                        ProgressView()
                                    }
                                    .scaledToFit()
                                    .frame(width: 32,height: 32)
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(20)
            .background(Color.theme.appBGSecondaryColor.opacity(0.6))
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(red: 0.29, green: 0.30, blue: 0.33).opacity(0.4), lineWidth: 1)
                )
        }
        .padding(.bottom)
    }
}
