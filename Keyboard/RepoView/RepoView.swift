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
    
    let columns = [
        GridItem(.adaptive(minimum: 45))
    ]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                if repoMan.selectedRepo != nil && repoMan.selectedRepo!.repo.favouriteEmotes != nil && repoMan.selectedRepo!.repo.favouriteEmotes!.count > 0 {
                    FavouritesView(repo: repoMan.selectedRepo!.repo, column: columns, flag: true)
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
                .padding(10)
            }
        }
        .frame(height: 260)
        .foregroundColor(Color.theme.textColor)
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
                    kbv.textDocumentProxy.insertText(imgUrl.absoluteString)
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
