//
//  RepoView.swift
//  Nitroless
//
//  Created by Lakhan Lothiyi on 29/09/2022.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI
import SDWebImageWebPCoder

struct RepoView: View {
    
    @Binding var toastShown: Bool
    
    var repo: Repo
    
    @State var stickBannerToTop = false
    var body: some View {
        ScrollView {
            LazyVStack {
                main
            }
            .padding(.horizontal, 4)
        }
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
                .opacity(stickBannerToTop ? 1 : 0)
            }
        }
    }
    
    @ViewBuilder
    var main: some View {
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
            withAnimation(.easeOut(duration: 0.2)) {
                stickBannerToTop = false
            }
        }
        .onDisappear {
            withAnimation(.easeOut(duration: 0.2)) {
                stickBannerToTop = true
            }
        }
        
        emotePalette
    }
    
    let columns = [
        GridItem(.adaptive(minimum: 40))
    ]
    
    @ViewBuilder
    var emotePalette: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(0..<repo.repoData!.emotes.count, id: \.self) { i in
                let emote = repo.repoData!.emotes[i]
                
                EmoteCell(repo: repo, emote: emote, toastShown: $toastShown)
            }
        }
    }
}

struct EmoteCell: View {
    var repo: Repo
    var emote: NitrolessEmote
    
    @Binding var toastShown: Bool
    
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
            } label: {
                Text("Copy Link")
            }

        }
    }
}
