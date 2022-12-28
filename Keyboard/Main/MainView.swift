//
//  MainView.swift
//  Keyboard
//
//  Created by Paras KCD on 2022-11-04.
//

import SwiftUI
import SDWebImageSwiftUI

struct MainView: View {
    @EnvironmentObject var kbv: KeyboardViewController
    @EnvironmentObject var repoMan: RepoManager
    
    @AppStorage("hideFavouriteEmotes", store: UserDefaults(suiteName: "group.llsc12.Nitroless")) private var hideFavouriteEmotes = false
    @AppStorage("hideFrequentlyUsedEmotes", store: UserDefaults(suiteName: "group.llsc12.Nitroless")) private var hideFrequentlyUsedEmotes = false
    @AppStorage("useEmotesAsStickers", store: UserDefaults(suiteName: "group.llsc12.Nitroless")) private var useEmotesAsStickers = false
    
    let column = [
        GridItem(.adaptive(minimum: 45))
    ]
    
    let stickerColumn = [
        GridItem(.adaptive(minimum: 65))
    ]
    
    @Binding var toastShown: Bool
    
    @Binding var repoMenu: RepoPages
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                if repoMan.hasStickers() {
                    Picker("RepoPages", selection: $repoMenu) {
                        ForEach(0..<RepoPages.allCases.count, id: \.self) {
                            i in
                            let type = RepoPages.allCases[i]
                            Text(type.rawValue).tag(type)
                        }
                    }
                    .clipShape(Capsule())
                    .overlay(Capsule().strokeBorder(Color.theme.appBGSecondaryColor, lineWidth: 3))
                    .pickerStyle(.segmented)
                    .padding(.horizontal, 50)
                    .padding(.top, 10)
                }
                
                if !hideFavouriteEmotes {
                    ContainerView(icon: "star", title: repoMenu == .emotes ? "Favourite Emotes" : "Favourite Stickers") {
                        LazyVStack {
                            if repoMenu == .emotes {
                                favouritesGrid
                            } else {
                                favouriteStickersGrid
                            }
                        }
                    }
                }
                
                if !hideFrequentlyUsedEmotes {
                    ContainerView(icon: "clock.arrow.circlepath", title: "Frequently used") {
                        if repoMenu == .emotes {
                            if repoMan.frequentlyUsed.count == 0 {
                                Text("Start using Nitroless to show your frequently used emotes here.")
                                    .frame(maxWidth: .infinity)
                            } else {
                                LazyVStack {
                                    emotesGrid
                                }
                            }
                        } else {
                            if repoMan.frequentlyUsedStickers.count == 0 {
                                Text("Start using Nitroless to show your frequently used stickers here.")
                                    .frame(maxWidth: .infinity)
                            } else {
                                LazyVStack {
                                    stickerGrid
                                }
                            }
                        }
                    }
                }
            }
        }
        .frame(height: 270)
        .foregroundColor(Color.theme.textColor)
    }
    
    @ViewBuilder
    var favouriteStickersGrid: some View {
        LazyVGrid(columns: stickerColumn) {
            let stickers = repoMan.favouriteStickers
            
            ForEach(0..<stickers.count, id: \.self) { i in
                let sticker = stickers[i]
                
                Button {
                    let imageUrlString = sticker.absoluteString
                    let imageCache: SDImageCache = SDImageCache.shared
                    let filepath = URL(filePath: imageCache.diskCache.cachePath(forKey: imageUrlString)!)
                    if let data = try? Data(contentsOf: filepath) {
                        if let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                UIPasteboard.general.image = image
                                toastShown = true
                            }
                        }
                    }
                    repoMan.selectedEmote = sticker.absoluteString
                    repoMan.addToFrequentlyUsedStickers(sticker: sticker.absoluteString)
                    repoMan.reloadFrequentlyUsedStickers()
                } label: {
                    let size: CGFloat = 65
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
        }
    }
    
    @ViewBuilder
    var favouritesGrid: some View {
        LazyVGrid(columns: column) {
            let emotes = repoMan.favouriteEmotes
            
            ForEach(0..<emotes.count, id: \.self) { i in
                let emote = emotes[i]
                
                Button {
                    if useEmotesAsStickers {
                        let imageUrlString = emote.absoluteString
                        let imageCache: SDImageCache = SDImageCache.shared
                        let filepath = URL(filePath: imageCache.diskCache.cachePath(forKey: imageUrlString)!)
                        if let data = try? Data(contentsOf: filepath) {
                            if imageUrlString.suffix(3) == "gif" {
                                DispatchQueue.main.async {
                                    UIPasteboard.general.setData(data, forPasteboardType: "com.compuserve.gif")
                                    toastShown = true
                                }
                            } else {
                                if let image = UIImage(data: data) {
                                    DispatchQueue.main.async {
                                        UIPasteboard.general.image = image
                                        toastShown = true
                                    }
                                }
                            }
                        }
                    } else {
                        kbv.textDocumentProxy.insertText(emote.absoluteString)
                    }
                    repoMan.selectedEmote = emote.absoluteString
                    repoMan.addToFrequentlyUsed(emote: emote.absoluteString)
                    repoMan.reloadFrequentlyUsed()
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
    }
    
    @ViewBuilder
    var stickerGrid: some View {
        LazyVGrid(columns: stickerColumn) {
            let stickers = repoMan.frequentlyUsedStickers
            
            ForEach(0..<stickers.count, id: \.self) { i in
                let sticker = stickers[i]
                
                Button {
                    let imageUrlString = sticker.absoluteString
                    let imageCache: SDImageCache = SDImageCache.shared
                    let filepath = URL(filePath: imageCache.diskCache.cachePath(forKey: imageUrlString)!)
                    if let data = try? Data(contentsOf: filepath) {
                        if let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                UIPasteboard.general.image = image
                                toastShown = true
                            }
                        }
                    }
                    repoMan.selectedEmote = sticker.absoluteString
                    repoMan.addToFrequentlyUsedStickers(sticker: sticker.absoluteString)
                    repoMan.reloadFrequentlyUsedStickers()
                } label: {
                    let size: CGFloat = 65
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
        }
    }
    
    @ViewBuilder
    var emotesGrid: some View {
        LazyVGrid(columns: column) {
            let emotes = repoMan.frequentlyUsed
            
            ForEach(0..<emotes.count, id: \.self) { i in
                let emote = emotes[i]
                
                Button {
                    if useEmotesAsStickers {
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
                    } else {
                        kbv.textDocumentProxy.insertText(emote.absoluteString)
                    }
                    repoMan.selectedEmote = emote.absoluteString
                    repoMan.addToFrequentlyUsed(emote: emote.absoluteString)
                    repoMan.reloadFrequentlyUsed()
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
    }
}
