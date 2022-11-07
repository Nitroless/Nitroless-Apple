//
//  FavouriteEmotesView.swift
//  Nitroless iOS
//
//  Created by Paras KCD on 2022-11-03.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI
import SDWebImageWebPCoder
import QuickLook

struct FavouriteEmotesView: View {
    @EnvironmentObject var repoMan: RepoManager
    @State var previewUrl: URL? = nil

    let emotes: [URL]
    
    @Binding var toastShown: Bool
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "star")
                Text("Favourite Emotes")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .font(.headline)
            
            Spacer()
            
            main.quickLookPreview($previewUrl).padding(.top, 20)
        }
        .padding(20)
        .background(Color.theme.appBGSecondaryColor)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(red: 0.29, green: 0.30, blue: 0.33).opacity(0.4), lineWidth: 1))
    }
    
    @ViewBuilder
    var main: some View {
        emotePalette
    }
    
    let columns = [
        GridItem(.adaptive(minimum: 50))
    ]
    
    @ViewBuilder
    var emotePalette: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            let emotes = emotes
            
            ForEach(0..<emotes.count, id: \.self) { i in
                let emote = emotes[i]
                
                Button {
                    UIPasteboard.general.url = emote
                    toastShown = true
                    repoMan.addToFrequentlyUsed(emote: emote.absoluteString)
                    repoMan.reloadFrequentlyUsed()
                } label: {
                    let size: CGFloat = 50
                    VStack {
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
                .contextMenu {
                    Button {
                        UIPasteboard.general.url = emote
                        toastShown = true
                        repoMan.addToFrequentlyUsed(emote: emote.absoluteString)
                        repoMan.reloadFrequentlyUsed()
                    } label: {
                        Label("Copy", systemImage: "doc.on.clipboard")
                    }
                    
                    Button {
                        let imageUrlString = emote.absoluteString
                        let imageCache: SDImageCache = SDImageCache.shared
                        let filepath = URL(filePath: imageCache.diskCache.cachePath(forKey: imageUrlString)!)
                        
                        self.previewUrl = filepath
                    } label: {
                        Label("Quick Look", systemImage: "magnifyingglass")
                    }
                }
            }
        }
    }
}
