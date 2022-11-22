//
//  FrequentUsedView.swift
//  Nitroless iOS
//
//  Created by Paras KCD on 2022-10-31.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI
import SDWebImageWebPCoder
import QuickLook

struct FrequentUsedView: View {
    @EnvironmentObject var repoMan: RepoManager
    
    @State var previewUrl: URL? = nil
    
    @Binding var toastShown: Bool
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "clock.arrow.circlepath")
                Text("Frequently used")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .font(.headline)
            
            Spacer()
            
            if repoMan.frequentlyUsed.count == 0 {
                Text("Start using Nitroless to show your frequently used emotes here.")
                    .frame(maxWidth: .infinity)
            } else {
                main.quickLookPreview($previewUrl)
            }
        }
        .padding(20)
        .background(Color.theme.appBGSecondaryColor)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(Color.theme.textColor.opacity(0.3), lineWidth: 1))
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
            let emotes = repoMan.frequentlyUsed
            
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
