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
            ContainerView(icon: "clock.arrow.circlepath", title: "Frequently used") {
                if repoMan.frequentlyUsed.count == 0 {
                    Text("Start using Nitroless to show your frequently used emotes here.")
                        .frame(maxWidth: .infinity)
                } else {
                    main.quickLookPreview($previewUrl)
                }
            }
            .padding(.bottom, repoMan.frequentlyUsedStickers.count > 0 ? 0 : 20)
            
            if repoMan.frequentlyUsedStickers.count != 0 {
                ContainerView(icon: "clock.arrow.circlepath", title: "Frequently used Stickers") {
                    stickerMain.quickLookPreview($previewUrl)
                }
                .padding(.bottom, 20)
            }
        }
    }
    
    @ViewBuilder
    var main: some View {
        emotePalette
    }
    
    @ViewBuilder
    var stickerMain: some View {
        stickerPalette
    }
    
    let columns = [
        GridItem(.adaptive(minimum: 50))
    ]
    
    let stickerColumns = [
        GridItem(.adaptive(minimum: 72))
    ]
    
    @ViewBuilder
    var stickerPalette: some View {
        LazyVGrid(columns: stickerColumns) {
            let stickers = repoMan.frequentlyUsedStickers
            
            ForEach(0..<stickers.count, id: \.self) { i in
                let sticker  = stickers[i]
                
                Button {
                    let imageUrlString = sticker.absoluteString
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
                    repoMan.addToFrequentlyUsedStickers(sticker: sticker.absoluteString)
                    repoMan.reloadFrequentlyUsedStickers()
                } label: {
                    let size: CGFloat = 72
                    
                    VStack {
                        WebImage(url: sticker)
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
                        let imageUrlString = sticker.absoluteString
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
                        repoMan.addToFrequentlyUsedStickers(sticker: sticker.absoluteString)
                        repoMan.reloadFrequentlyUsedStickers()
                    } label: {
                        Label("Copy", systemImage: "doc.on.clipboard")
                    }
                    Button {
                        let imageUrlString = sticker.absoluteString
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
