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
    
    @Binding var toastShown: Bool
    
    var repo: Repo
    
    @State var showDetails = false
    
    @State var previewUrl: URL? = nil
    
    @State var searchText = ""
    
    var body: some View {
        ScrollView {
            LazyVStack {
                main
                    .quickLookPreview($previewUrl)
            }
            .padding(.horizontal)
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer, prompt: Text("Search Repository"))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    let url = repo.url
                    let imgUrl = url.appending(path: repo.repoData!.icon)
                    WebImage(url: imgUrl)
                        .resizable()
                        .placeholder {
                            ProgressView()
                        }
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 20)
                        .clipShape(Circle())
                    Text(repo.repoData!.name)
                }
//                .opacity(stickBannerToTop ? 1 : 0)
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showDetails = true
                } label: {
                    Image(systemName: "info.circle")
                }
                .sheet(isPresented: $showDetails) {
                    info
                        .presentationDetents([.fraction(0.1)])
                }
            }
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
                        .font(.title)
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
            .padding()
            .background(.thickMaterial)
            .clipShape(Capsule())
            .padding(.horizontal)
        }
    }
    
    @ViewBuilder
    var main: some View {
        emotePalette
    }
    
    let columns = [
        GridItem(.adaptive(minimum: 40))
    ]
    
    @ViewBuilder
    var emotePalette: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            let emotes = repo.repoData!.emotes
            let filtered = emotes.filter { emote in
                emote.name.lowercased().contains(searchText) || searchText.isEmpty
            }
            
            ForEach(0..<filtered.count, id: \.self) { i in
                let emote = filtered[i]
                
                EmoteCell(repo: repo, emote: emote, toastShown: $toastShown, ql: $previewUrl)
            }
        }
    }
}

struct EmoteCell: View {
    var repo: Repo
    var emote: NitrolessEmote
    
    @Binding var toastShown: Bool
    @Binding var ql: URL?
    
    var body: some View {
        let imgUrl = repo.url
            .appending(path: repo.repoData!.path)
            .appending(path: emote.name)
            .appendingPathExtension(emote.type)
        
        Button {
            toastShown = true
            UIPasteboard.general.url = imgUrl
        } label: {
            VStack {
                WebImage(url: imgUrl)
                    .resizable()
                    .placeholder {
                        ProgressView()
                    }
                    .aspectRatio(contentMode: .fit)
            }
        }
        .contextMenu {
            Text(emote.name)
            
            Divider()
            
            Button {
                UIPasteboard.general.url = imgUrl
                toastShown = true
            } label: {
                Label("Copy", systemImage: "doc.on.clipboard")
            }
            
            Button {
                #warning("Add favourites internal repo")
            } label: {
                Label("Favourite", systemImage: "star")
            }
            .disabled(true)
            
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
