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
    
    var body: some View {
        ScrollView {
            VStack {
                info
                
                if repoMan.selectedRepo != nil && repoMan.selectedRepo!.repo.favouriteEmotes != nil && repoMan.selectedRepo!.repo.favouriteEmotes!.count > 0 {
                    favouriteEmotesMain.quickLookPreview($previewUrl)
                }
                
                LazyVStack {
                    main
                        .quickLookPreview($previewUrl)
                }
                .padding(20)
                .background(Color.theme.appBGSecondaryColor)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(Color.theme.appBGTertiaryColor.opacity(0.2), lineWidth: 1))
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(10)
        .padding(.trailing, idiom == .pad && horizontalSizeClass == .regular ? 40 : 0)
        .padding(.leading, idiom == .pad && horizontalSizeClass == .regular ? 25 : 0)
//        .searchable(text: $searchText, placement: .navigationBarDrawer, prompt: Text("Search Repository"))
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
                        .font(.custom("Uni Sans", size: 24))
                    if let author = repo.repoData!.author {
                        Text("By \(author)")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                }
                Spacer()
                Text("\(repo.repoData!.emotes.count) emotes")
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(Color.theme.appBGTertiaryColor)
        .clipShape(Capsule())
        .overlay(Capsule().strokeBorder(Color.theme.appBGTertiaryColor.opacity(0.2), lineWidth: 1))
    }
    
    @ViewBuilder
    var main: some View {
        emotePalette
    }
    
    let columns = [
        GridItem(.adaptive(minimum: 50))
    ]
    
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
                    UIPasteboard.general.url = emoteURL
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
                UIPasteboard.general.url = imgUrl
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
                    UIPasteboard.general.url = imgUrl
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
