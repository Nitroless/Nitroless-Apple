//
//  FavouritesView.swift
//  Keyboard
//
//  Created by Paras KCD on 2022-11-05.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavouritesView: View {
    @EnvironmentObject var repoMan: RepoManager
    var repo: Repo
    var kbv: KeyboardViewController
    var column: [GridItem]
    var flag: Bool
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "star")
                if flag {
                    Text("Favourite Emotes")
                        .frame(maxWidth: .infinity, alignment: .leading)
                } else {
                    Text("\(repo.repoData!.name)'s Favourite Emotes")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .font(.headline)
            
            Spacer()
            
            LazyVStack {
                LazyVGrid(columns: column) {
                    let emotes = repo.favouriteEmotes
                    
                    ForEach(0..<emotes!.count, id: \.self) { i in
                        let emote = emotes![i]
                        
                        Button {
                            kbv.textDocumentProxy.insertText(emote.absoluteString)
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
        .padding(20)
        .background(Color.theme.appBGSecondaryColor)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(red: 0.29, green: 0.30, blue: 0.33).opacity(0.4), lineWidth: 1))
        .padding([.top, .horizontal], 10)
    }
}
