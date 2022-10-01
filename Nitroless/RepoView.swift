//
//  RepoView.swift
//  Nitroless
//
//  Created by Lakhan Lothiyi on 29/09/2022.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct RepoView: View {
    
    var repo: Repo
    var url: URL
    
    @State var stickBannerToTop = false
    var body: some View {
        ScrollView {
            LazyVStack {
                main
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
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
                .opacity(stickBannerToTop ? 1 : 0)
            }
        }
    }
    
    @ViewBuilder
    var main: some View {
        HStack {
            let imgUrl = url.appending(path: repo.repoData!.icon)
            WebImage(url: imgUrl)
                .resizable()
                .placeholder {
                    ProgressView()
                }
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 60)
                .clipShape(Circle())
            Text(repo.repoData!.name)
                .font(.title)
            Spacer()
            
            Text("\(repo.repoData!.emotes.count) emotes")
                .foregroundColor(.secondary)
        }
        .padding()
        .background(.thickMaterial)
        .clipShape(Capsule())
        .offset(y: -20)
        .onAppear {
            withAnimation(.easeOut) {
                stickBannerToTop = false
            }
        }
        .onDisappear {
            withAnimation(.easeOut) {
                stickBannerToTop = true
            }
        }
        
        emotePalette
    }
    
    let columns = [
        GridItem(.adaptive(minimum: 80))
    ]
    
    @ViewBuilder
    var emotePalette: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(0..<repo.repoData!.emotes.count, id: \.self) { i in
                let emote = repo.repoData!.emotes[i]
                
                emoteCell(repo: repo, emote: emote)
            }
        }
    }
    
    @ViewBuilder
    func emoteCell(repo: Repo, emote: NitrolessEmote) -> some View {
        VStack {
            let imgUrl = repo.url
                .appending(path: repo.repoData!.path)
                .appending(path: emote.name)
                .appendingPathExtension(emote.type)
            WebImage(url: imgUrl)
                .resizable()
                .placeholder {
                    ProgressView()
                }
                .aspectRatio(contentMode: .fit)
        }
    }
}

var example = NitrolessRepo(name: "Lillie's Repo", icon: "icon.jpg", path: "emotes", emotes:
                                [
                                    NitrolessEmote(name: "02love", type: ".webp"),
                                    NitrolessEmote(name: "menheraheart", type: ".webp")
                                ]
)
