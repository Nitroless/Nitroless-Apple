//
//  RepoView.swift
//  Nitroless
//
//  Created by Lakhan Lothiyi on 29/09/2022.
//

import Foundation
import SwiftUI
import SDWebImage
import SDWebImageSwiftUI
import SDWebImageWebPCoder
import QuickLook

struct RepoView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @EnvironmentObject var repoMan: RepoManager
    
    @Binding var toastShown: Bool
    
    var repo: Repo
    
    @State var showDetails = false
    @State var previewUrl: URL? = nil
    @State var searchText = ""
    @State var urlToDelete: URL? = nil
    @State var showDeletePrompt = false
    
    private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    
   @Binding var repoMenu: RepoPages
    
    var body: some View {
        if idiom == .pad && horizontalSizeClass == .regular {
            ScrollView {
                VStack {
                    info
                    
                    HStack {
                        TextField("Search Repository...", text: $searchText)
                            .padding()
                    }
                    .padding(5)
                    .background(Color.theme.appBGSecondaryColor)
                    .clipShape(Capsule())
                    .overlay(Capsule().strokeBorder(Color.theme.appBGTertiaryColor.opacity(0.2), lineWidth: 1))
                    .padding(.top, 10)
                    .padding(.horizontal, 15)
                    .shadow(color: Color.theme.appBGTertiaryColor.opacity(0.5), radius: 10, x: -2, y: 7)

                    if repoMan.selectedRepo != nil && repoMan.selectedRepo!.repo.favouriteEmotes != nil && repoMan.selectedRepo!.repo.favouriteEmotes!.count > 0 {
                        favouriteEmotesMain.quickLookPreview($previewUrl)
                    }
                    if repoMan.selectedRepo != nil && repoMan.selectedRepo!.repo.favouriteStickers != nil && repoMan.selectedRepo!.repo.favouriteStickers!.count > 0 {
                        favouriteStickersMain.quickLookPreview($previewUrl)
                    }
                    
                    LazyVStack {
                        if repoMan.selectedRepo != nil && repoMan.selectedRepo!.repo.repoData != nil && repoMan.selectedRepo!.repo.repoData!.stickers != nil && repoMan.selectedRepo!.repo.repoData!.stickers!.count > 0 {
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
                            .padding(.bottom, 20)
                        }
                        
                        if repoMenu == .emotes {
                            main
                                .quickLookPreview($previewUrl)
                        } else {
                            stickerMain
                        }
                    }
                    .padding(20)
                    .background(Color.theme.appBGSecondaryColor)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .strokeBorder(Color.theme.appBGTertiaryColor.opacity(0.2), lineWidth: 1))
                    .padding(.top, 10)
                    .padding(.bottom, 30)
                    .padding(.horizontal, 15)
                    .shadow(color: Color.theme.appBGTertiaryColor.opacity(0.5), radius: 10, x: -2, y: 7)
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(10)
            .padding(.trailing, idiom == .pad && horizontalSizeClass == .regular ? 40 : 0)
            .padding(.leading, idiom == .pad && horizontalSizeClass == .regular ? 25 : 0)
        } else {
            ScrollView {
                VStack {
                    info
                    
                    if repoMan.selectedRepo != nil && repoMan.selectedRepo!.repo.favouriteEmotes != nil && repoMan.selectedRepo!.repo.favouriteEmotes!.count > 0 {
                        favouriteEmotesMain.quickLookPreview($previewUrl)
                    }
                    
                    if repoMan.selectedRepo != nil && repoMan.selectedRepo!.repo.favouriteStickers != nil && repoMan.selectedRepo!.repo.favouriteStickers!.count > 0 {
                        favouriteStickersMain.quickLookPreview($previewUrl)
                    }
                    
                    LazyVStack {
                        if repoMan.selectedRepo != nil && repoMan.selectedRepo!.repo.repoData != nil && repoMan.selectedRepo!.repo.repoData!.stickers != nil && repoMan.selectedRepo!.repo.repoData!.stickers!.count > 0 {
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
                            .padding(.bottom, 20)
                        }
                        
                        if repoMenu == .emotes {
                            main
                                .quickLookPreview($previewUrl)
                        } else {
                            stickerMain
                                .quickLookPreview($previewUrl)
                        }
                    }
                    .padding(20)
                    .background(Color.theme.appBGSecondaryColor)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .strokeBorder(Color.theme.appBGTertiaryColor.opacity(0.2), lineWidth: 1))
                    .padding(.top, 10)
                    .padding(.bottom, 30)
                    .padding(.horizontal, 15)
                    .shadow(color: Color.theme.appBGTertiaryColor.opacity(0.5), radius: 10, x: -2, y: 7)
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(10)
            .padding(.trailing, idiom == .pad && horizontalSizeClass == .regular ? 40 : 0)
            .padding(.leading, idiom == .pad && horizontalSizeClass == .regular ? 25 : 0)
            .searchable(text: $searchText, placement: .navigationBarDrawer, prompt: Text("Search Repository..."))
        }
    }
    
    @ViewBuilder
    var info: some View {
        VStack {
            HStack {
                let url = repo.url
                let imgUrl = url.appending(path: repo.repoData!.icon)
                WebImage(url: imgUrl)
                    .resizable()
                    .placeholder {
                        ProgressView()
                    }
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 60)
                    .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text(repo.repoData!.name)
                        .font(.headline)
                    
                    if let author = repo.repoData!.author {
                        Text("By \(author)")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                }
                Spacer()
                if repoMenu == .emotes {
                    Text("\(repo.repoData!.emotes.count) emotes")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                } else {
                    if repo.repoData!.stickers != nil {
                        Text("\(repo.repoData!.stickers!.count) stickers")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(Color.theme.appBGTertiaryColor)
        .clipShape(Capsule())
        .overlay(Capsule().strokeBorder(Color.theme.appBGTertiaryColor.opacity(0.2), lineWidth: 1))
        .padding(.top, 10)
        .padding(.horizontal, 15)
        .shadow(color: Color.theme.appBGTertiaryColor.opacity(0.5), radius: 10, x: -2, y: 7)
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
    var favouriteStickersMain: some View {
        VStack {
            HStack {
                Image(systemName: "star")
                Text("Favourite Stickers")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .font(.headline)
            
            LazyVGrid(columns: stickerColumns) {
                ForEach(0..<repoMan.selectedRepo!.repo.favouriteStickers!.count, id: \.self) { i in
                    let sticker = repoMan.selectedRepo!.repo.favouriteStickers![i]
                   
                    StickerCell(favouriteFlag: true, stickerURL: sticker, repoMan: repoMan, toastShown: $toastShown, ql: $previewUrl)
                }
            }
        }
        .padding(20)
        .background(Color.theme.appBGSecondaryColor)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(Color.theme.appBGTertiaryColor.opacity(0.2), lineWidth: 1))
        .padding(.top, 10)
        .padding(.horizontal, 15)
        .shadow(color: Color.theme.appBGTertiaryColor.opacity(0.5), radius: 10, x: -2, y: 7)
    }
    
    @ViewBuilder
    var favouriteEmotesMain: some View {
        VStack {
            HStack {
                Image(systemName: "star")
                Text("Favourite Emotes")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .font(.headline)
            
            LazyVGrid(columns: columns) {
                ForEach(0..<repoMan.selectedRepo!.repo.favouriteEmotes!.count, id: \.self) { i in
                    let emote = repoMan.selectedRepo!.repo.favouriteEmotes![i]
                    EmoteCell(favouriteFlag: true, repo: repo, emoteURL: emote, toastShown: $toastShown, ql: $previewUrl, repoMan: repoMan)
                }
            }
        }
        .padding(20)
        .background(Color.theme.appBGSecondaryColor)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(Color.theme.appBGTertiaryColor.opacity(0.2), lineWidth: 1))
        .padding(.top, 10)
        .padding(.horizontal, 15)
        .shadow(color: Color.theme.appBGTertiaryColor.opacity(0.5), radius: 10, x: -2, y: 7)
    }
    
    @ViewBuilder
    var emotePalette: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            let emotes = repo.repoData!.emotes
            let filtered = emotes.filter { emote in
                emote.name.lowercased().contains(searchText.lowercased()) || searchText.isEmpty
            }
            
            ForEach(0..<filtered.count, id: \.self) { i in
                let emote = filtered[i]
                
                EmoteCell(favouriteFlag: false, repo: repo, emote: emote, toastShown: $toastShown, ql: $previewUrl, repoMan: repoMan)
            }
        }
    }
    
    @ViewBuilder
    var stickerPalette: some View {
        LazyVGrid(columns: stickerColumns) {
            let stickers = repo.repoData!.stickers
            if stickers != nil {
                let filtered = stickers!.filter { sticker in
                    sticker.name.lowercased().contains(searchText.lowercased()) || searchText.isEmpty
                }
                
                ForEach(0..<filtered.count, id: \.self) { i in
                    let sticker = filtered[i]
                    StickerCell(favouriteFlag: false, repo: repo, sticker: sticker, repoMan: repoMan, toastShown: $toastShown, ql: $previewUrl)
                }
            }
        }
    }
}

struct StickerCell: View {
    var favouriteFlag: Bool
    var repo: Repo?
    var sticker: NitrolessSticker?
    var stickerURL: URL?
    var repoMan: RepoManager
    @Binding var toastShown: Bool
    @Binding var ql: URL?
    
    var body: some View {
        let size: CGFloat = 72
        
        if favouriteFlag {
            if stickerURL != nil {
                Button {
                    UIPasteboard.general.url = stickerURL
                    toastShown = true
                    repoMan.addToFrequentlyUsedStickers(sticker: stickerURL!.absoluteString)
                } label: {
                    VStack {
                        WebImage(url: stickerURL)
                            .resizable()
                            .placeholder{ ProgressView() }
                            .aspectRatio(contentMode: .fit)
                            .frame(width: size, height: size)
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    }
                }
                .contextMenu {
                    Button {
                        let imageUrlString = stickerURL!.absoluteString
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
                        repoMan.addToFrequentlyUsedStickers(sticker: stickerURL!.absoluteString)
                    } label: {
                        Label("Copy", systemImage: "doc.on.clipboard")
                    }
                    Button(role: .destructive) {
                        if repo != nil && stickerURL != nil {
                            repoMan.removeStickerFromFavourites(repo: repo!.url.absoluteString, sticker: stickerURL!.absoluteString)
                        }
                    } label: {
                        Label("Unfavourite", systemImage: "star.fill")
                    }
                    Button {
                        let imageUrlString = stickerURL!.absoluteString
                        let imageCache: SDImageCache = SDImageCache.shared
                        let filepath = URL(filePath: imageCache.diskCache.cachePath(forKey: imageUrlString)!)
                        
                        ql = filepath
                    } label: {
                        Label("Quick Look", systemImage: "magnifyingglass")
                    }
                }
            }
        } else {
            if repo != nil && repo?.repoData != nil && repo?.repoData?.stickerPath != nil && sticker != nil {
                let imgUrl = repo!.url
                    .appending(path: repo!.repoData!.stickerPath!)
                    .appending(path: sticker!.name)
                    .appendingPathExtension(sticker!.type)
                
                
                
                Button {
                    UIPasteboard.general.url = imgUrl
                    toastShown = true
                    repoMan.addToFrequentlyUsedStickers(sticker: imgUrl.absoluteString)
                } label: {
                    VStack {
                        WebImage(url: imgUrl)
                            .resizable()
                            .placeholder { ProgressView() }
                            .aspectRatio(contentMode: .fit)
                            .frame(width: size, height: size)
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    }
                }
                .contextMenu {
                    Text(sticker!.name)
                    
                    Divider()
                    
                    Button {
                        let imageUrlString = imgUrl.absoluteString
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
                        repoMan.addToFrequentlyUsedStickers(sticker: imgUrl.absoluteString)
                    } label: {
                        Label("Copy", systemImage: "doc.on.clipboard")
                    }
                    
                    Button(role: repo!.favouriteStickers != nil && repo!.favouriteStickers!.count > 0 && repo!.favouriteStickers!.contains(where: { url in
                        url == imgUrl
                    }) ? .destructive : .none) {
                        if repo!.favouriteStickers != nil && repo!.favouriteStickers!.count > 0 && repo!.favouriteStickers!.contains(where: { url in
                            url == imgUrl
                        }) {
                            repoMan.removeStickerFromFavourites(repo: repo!.url.absoluteString, sticker: imgUrl.absoluteString)
                        } else {
                            repoMan.addToFavouriteStickers(repo: repo!.url.absoluteString, sticker: imgUrl.absoluteString)
                        }
                    } label: {
                        Label(repo!.favouriteStickers != nil && repo!.favouriteStickers!.count > 0 && repo!.favouriteStickers!.contains(where: { url in
                            url == imgUrl
                        }) ? "Unfavourite" : "Favourite", systemImage: repo!.favouriteStickers != nil && repo!.favouriteStickers!.count > 0 && repo!.favouriteStickers!.contains(where: { url in
                            url == imgUrl
                        }) ? "star.fill" : "star")
                    }
                    
                    Button {
                        let imageUrlString = imgUrl.absoluteString
                        let imageCache: SDImageCache = SDImageCache.shared
                        let filepath = URL(filePath: imageCache.diskCache.cachePath(forKey: imageUrlString)!)
                        
                        ql = filepath
                    } label: {
                        Label("Quick Look", systemImage: "magnifyingglass")
                    }
                }
            }
        }
    }
}

struct EmoteCell: View {
    var favouriteFlag: Bool
    var repo: Repo?
    var emote: NitrolessEmote?
    var emoteURL: URL?
    
    @Binding var toastShown: Bool
    @Binding var ql: URL?
    
    var repoMan: RepoManager
    
    var body: some View {
        if favouriteFlag {
            Button {
                UIPasteboard.general.url = emoteURL
                toastShown = true
                repoMan.addToFrequentlyUsed(emote: emoteURL!.absoluteString)
            } label: {
                let size: CGFloat = 50
                VStack {
                    WebImage(url: emoteURL)
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
                    let imageUrlString = emoteURL!.absoluteString
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
                    repoMan.addToFrequentlyUsed(emote: emoteURL!.absoluteString)
                } label: {
                    Label("Copy", systemImage: "doc.on.clipboard")
                }
                
                Button(role: .destructive) {
                    if repo != nil {
                        repoMan.removeFromFavourite(repo: repo!.url.absoluteString, emote: emoteURL!.absoluteString)
                    }
                    
                } label: {
                    Label("Unfavourite", systemImage: "star.fill")
                }
                
                Button {
                    let imageUrlString = emoteURL!.absoluteString
                    let imageCache: SDImageCache = SDImageCache.shared
                    let filepath = URL(filePath: imageCache.diskCache.cachePath(forKey: imageUrlString)!)
                    
                    ql = filepath
                } label: {
                    Label("Quick Look", systemImage: "magnifyingglass")
                }
            }
        } else {
            let imgUrl = repo!.url
                .appending(path: repo!.repoData!.path)
                .appending(path: emote!.name)
                .appendingPathExtension(emote!.type)
            
            Button {
                UIPasteboard.general.url = emoteURL
                toastShown = true
                repoMan.addToFrequentlyUsed(emote: imgUrl.absoluteString)
            } label: {
                let size: CGFloat = 50
                VStack {
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
            .contextMenu {
                Text(emote!.name)
                
                Divider()
                
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
                                }
                            }
                        }
                    }
                    toastShown = true
                    repoMan.addToFrequentlyUsed(emote: imgUrl.absoluteString)
                } label: {
                    Label("Copy", systemImage: "doc.on.clipboard")
                }
                
                Button(role: repo!.favouriteEmotes != nil && repo!.favouriteEmotes!.count > 0 && repo!.favouriteEmotes!.contains(where: { url in
                    url == imgUrl
                }) ? .destructive : .none) {
                    if repo!.favouriteEmotes != nil && repo!.favouriteEmotes!.count > 0 && repo!.favouriteEmotes!.contains(where: { url in
                        url == imgUrl
                    }) {
                        repoMan.removeFromFavourite(repo: repo!.url.absoluteString, emote: imgUrl.absoluteString)
                    } else {
                        repoMan.addToFavourites(repo: repo!.url.absoluteString, emote: imgUrl.absoluteString)
                    }
                } label: {
                    Label(repo!.favouriteEmotes != nil && repo!.favouriteEmotes!.count > 0 && repo!.favouriteEmotes!.contains(where: { url in
                        url == imgUrl
                    }) ? "Unfavourite" : "Favourite", systemImage: repo!.favouriteEmotes != nil && repo!.favouriteEmotes!.count > 0 && repo!.favouriteEmotes!.contains(where: { url in
                        url == imgUrl
                    }) ? "star.fill" : "star")
                }
                
                Button {
                    let imageUrlString = imgUrl.absoluteString
                    let imageCache: SDImageCache = SDImageCache.shared
                    let filepath = URL(filePath: imageCache.diskCache.cachePath(forKey: imageUrlString)!)
                    
                    ql = filepath
                } label: {
                    Label("Quick Look", systemImage: "magnifyingglass")
                }
            }
        }
    }
}

