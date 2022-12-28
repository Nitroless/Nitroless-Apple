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
    
    let stickerFlag: Bool
    
    var body: some View {
        ContainerView(icon: "star", title: stickerFlag ? "Favourite Stickers" : "Favourite Emotes") {
            main.quickLookPreview($previewUrl).padding(.top, 20)
        }
    }
    
    @ViewBuilder
    var main: some View {
        emotePalette
    }
    
    let columns = [
        GridItem(.adaptive(minimum: 50))
    ]
    
    let stickerColumns = [
        GridItem(.adaptive(minimum: 72))
    ]
    
    @ViewBuilder
    var emotePalette: some View {
        LazyVGrid(columns: stickerFlag ? stickerColumns : columns, spacing: stickerFlag ? 10 : 20) {
            let emotes = emotes
            
            ForEach(0..<emotes.count, id: \.self) { i in
                let emote = emotes[i]
                
                Button {
                    if stickerFlag {
                        let imageUrlString = emote.absoluteString
                        let imageCache: SDImageCache = SDImageCache.shared
                        let filepath = URL(filePath: imageCache.diskCache.cachePath(forKey: imageUrlString)!)
                        if let data = try? Data(contentsOf: filepath) {
                            if let image = UIImage(data: data) {
                                DispatchQueue.main.async {
                                    UIPasteboard.general.image = image
                                }
                            }
                        }
                        toastShown = true
                        repoMan.addToFrequentlyUsedStickers(sticker: emote.absoluteString)
                        repoMan.reloadFrequentlyUsedStickers()
                    } else {
                        UIPasteboard.general.url = emote
                        toastShown = true
                        repoMan.addToFrequentlyUsed(emote: emote.absoluteString)
                        repoMan.reloadFrequentlyUsed()
                    }
                } label: {
                    let size: CGFloat = stickerFlag ? 72 : 50
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
                        let imageUrlString = emote.absoluteString
                        let imageCache: SDImageCache = SDImageCache.shared
                        let filepath = URL(filePath: imageCache.diskCache.cachePath(forKey: imageUrlString)!)
                        if let data = try? Data(contentsOf: filepath) {
                            if imageUrlString.suffix(3) == "gif" {
                                DispatchQueue.main.async {
                                    UIPasteboard.general.setData(data, forPasteboardType: "com.compuserve.gif")
                                }
                            } else {
                                if let image = UIImage(data: data) {
                                    DispatchQueue.main.async {
                                        UIPasteboard.general.image = image
                                    }
                                }
                            }
                        }

                        toastShown = true
                        
                        if stickerFlag {
                            repoMan.addToFrequentlyUsedStickers(sticker: emote.absoluteString)
                            repoMan.reloadFrequentlyUsedStickers()
                        } else {
                            repoMan.addToFrequentlyUsed(emote: emote.absoluteString)
                            repoMan.reloadFrequentlyUsed()
                        }
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
