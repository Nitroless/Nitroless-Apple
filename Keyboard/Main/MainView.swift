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
                    if repoMenu == .emotes {
                        if repoMan.favouriteEmotes.count > 0 {
                            VStack {
                                HStack {
                                    Image(systemName: "star")
                                    Text("Favourite Emotes")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .font(.headline)
                                
                                Spacer()
                                
                                LazyVStack {
                                    favouritesGrid
                                }
                            }
                            .padding(20)
                            .background(Color.theme.appBGSecondaryColor)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .strokeBorder(Color.theme.appBGTertiaryColor.opacity(0.2), lineWidth: 1))
                            .padding([.top, .horizontal], 10)
                            .shadow(color: Color.theme.appBGTertiaryColor.opacity(0.5), radius: 10, x: -2, y: 7)
                        }
                    } else {
                        if repoMan.favouriteStickers.count > 0 {
                            VStack {
                                HStack {
                                    Image(systemName: "star")
                                    Text("Favourite Stickers")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .font(.headline)
                                
                                Spacer()
                                
                                LazyVStack {
                                    favouriteStickersGrid
                                }
                            }
                            .padding(20)
                            .background(Color.theme.appBGSecondaryColor)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .strokeBorder(Color.theme.appBGTertiaryColor.opacity(0.2), lineWidth: 1))
                            .padding([.top, .horizontal], 10)
                            .shadow(color: Color.theme.appBGTertiaryColor.opacity(0.5), radius: 10, x: -2, y: 7)
                        }
                    }
                }
                
                if !hideFrequentlyUsedEmotes {
                    if repoMenu == .emotes {
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
                                LazyVStack {
                                    emotesGrid
                                }
                            }
                        }
                        .padding(20)
                        .background(Color.theme.appBGSecondaryColor)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .strokeBorder(Color.theme.appBGTertiaryColor.opacity(0.2), lineWidth: 1))
                        .padding([.top, .horizontal], 10)
                        .padding(.bottom, 20)
                        .shadow(color: Color.theme.appBGTertiaryColor.opacity(0.5), radius: 10, x: -2, y: 7)
                    } else {
                        VStack {
                            HStack {
                                Image(systemName: "clock.arrow.circlepath")
                                Text("Frequently used")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .font(.headline)
                            
                            Spacer()
                            
                            if repoMan.frequentlyUsedStickers.count == 0 {
                                Text("Start using Nitroless to show your frequently used stickers here.")
                                    .frame(maxWidth: .infinity)
                            } else {
                                LazyVStack {
                                    stickerGrid
                                }
                            }
                        }
                        .padding(20)
                        .background(Color.theme.appBGSecondaryColor)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .strokeBorder(Color.theme.appBGTertiaryColor.opacity(0.2), lineWidth: 1))
                        .padding([.top, .horizontal], 10)
                        .padding(.bottom, 20)
                        .shadow(color: Color.theme.appBGTertiaryColor.opacity(0.5), radius: 10, x: -2, y: 7)
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
