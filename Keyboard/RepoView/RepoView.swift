//
//  RepoView.swift
//  Keyboard
//
//  Created by Paras KCD on 2022-11-04.
//

import SwiftUI
import SDWebImageSwiftUI

struct RepoView: View {
    @EnvironmentObject var kbv: KeyboardViewController
    @EnvironmentObject var repoMan: RepoManager
    @AppStorage("useEmotesAsStickers", store: UserDefaults(suiteName: "group.llsc12.Nitroless")) private var useEmotesAsStickers = false
    
    let columns = [
        GridItem(.adaptive(minimum: 45))
    ]
    
    let stickerColumns = [
        GridItem(.adaptive(minimum: 65))
    ]
    
    @Binding var toastShown: Bool
    
    @Binding var repoMenu: RepoPages
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                if repoMan.hasRepoStickers(repo: repoMan.selectedRepo?.repo) {
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
                
                if repoMenu == .emotes {
                    if repoMan.selectedRepo != nil && repoMan.selectedRepo!.repo.favouriteEmotes != nil && repoMan.selectedRepo!.repo.favouriteEmotes!.count > 0 {
                        FavouritesView(repo: repoMan.selectedRepo!.repo, column: columns, flag: true)
                    }
                } else {
                    if repoMan.selectedRepo != nil && repoMan.selectedRepo!.repo.favouriteStickers != nil && repoMan.selectedRepo!.repo.favouriteStickers!.count > 0 {
                        FavouritesView(repo: repoMan.selectedRepo!.repo, column: stickerColumns, flag: false)
                    }
                }
                
                VStack {
                    if repoMan.selectedRepo != nil {
                        HStack {
                            let imgUrl = repoMan.selectedRepo!.repo.url.appending(path: repoMan.selectedRepo!.repo.repoData!.icon)
                            WebImage(url: imgUrl)
                                .resizable()
                                .placeholder {
                                    ProgressView()
                                }
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                            Text(repoMan.selectedRepo!.repo.repoData!.name)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .font(.headline)
                        
                        Spacer()
                        
                        LazyVStack {
                            if repoMan.selectedRepo!.repo.repoData != nil {
                                if repoMenu == .emotes {
                                    emotesGrid
                                } else {
                                    stickersGrid
                                }
                            }
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
        .frame(height: 270)
        .foregroundColor(Color.theme.textColor)
    }
    
    @ViewBuilder
    var stickersGrid: some View {
        LazyVGrid(columns: stickerColumns) {
            let stickers = repoMan.selectedRepo!.repo.repoData!.stickers
            
            if stickers != nil {
                ForEach(0..<stickers!.count, id: \.self) { i in
                    let sticker = stickers![i]
                    
                    let imgUrl = repoMan.selectedRepo!.repo.url
                        .appending(path: repoMan.selectedRepo!.repo.repoData!.stickerPath!)
                        .appending(path: sticker.name)
                        .appendingPathExtension(sticker.type)
                    
                    Button {
                        let imageUrlString = imgUrl.absoluteString
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
                                        toastShown = true
                                    }
                                }
                            }
                        }
                        repoMan.selectedEmote = imgUrl.absoluteString
                        repoMan.addToFrequentlyUsedStickers(sticker: imgUrl.absoluteString)
                        repoMan.reloadFrequentlyUsedStickers()
                    } label: {
                        let size: CGFloat = 65
                        WebImage(url: imgUrl)
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
    
    @ViewBuilder
    var emotesGrid: some View {
        LazyVGrid(columns: columns) {
            let emotes = repoMan.selectedRepo!.repo.repoData!.emotes
            
            ForEach(0..<emotes.count, id: \.self) { i in
                let emote = emotes[i]
                
                let imgUrl = repoMan.selectedRepo!.repo.url
                    .appending(path: repoMan.selectedRepo!.repo.repoData!.path)
                    .appending(path: emote.name)
                    .appendingPathExtension(emote.type)
                
                Button {
                    if useEmotesAsStickers {
                        let imageUrlString = imgUrl.absoluteString
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
                        kbv.textDocumentProxy.insertText(imgUrl.absoluteString)
                    }
                    repoMan.selectedEmote = imgUrl.absoluteString
                    repoMan.addToFrequentlyUsed(emote: imgUrl.absoluteString)
                    repoMan.reloadFrequentlyUsed()
                } label: {
                    let size: CGFloat = 40
                    WebImage(url: imgUrl)
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
