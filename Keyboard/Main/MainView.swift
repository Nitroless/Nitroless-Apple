//
//  MainView.swift
//  Keyboard
//
//  Created by Paras KCD on 2022-11-04.
//

import SwiftUI
import SDWebImageSwiftUI

struct MainView: View {
    var kbv: KeyboardViewController
    @EnvironmentObject var repoMan: RepoManager
    
    let column = [
        GridItem(.adaptive(minimum: 45))
    ]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                ForEach(repoMan.repos, id: \.url) { repo in
                    if repo.favouriteEmotes != nil && repo.favouriteEmotes!.count > 0 {
                        FavouritesView(repo: repo, kbv: kbv, column: column, flag: false)
                            .environmentObject(repoMan)
                    }
                }
                
                VStack {
                    HStack {
                        Image(systemName: "clock.arrow.circlepath")
                        Text("Frequently used emotes")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .font(.headline)
                    
                    Spacer()
                    
                    if repoMan.frequentlyUsed.count == 0 {
                        Text("Start using Nitroless \nto show your frequently used emotes here.")
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
                        .stroke(Color(red: 0.29, green: 0.30, blue: 0.33).opacity(0.4), lineWidth: 1))
                .padding(10)
            }
        }
        .frame(height: 260)
        
    }
    
    @ViewBuilder
    var emotesGrid: some View {
        LazyVGrid(columns: column) {
            let emotes = repoMan.frequentlyUsed
            
            ForEach(0..<emotes.count, id: \.self) { i in
                let emote = emotes[i]
                
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
