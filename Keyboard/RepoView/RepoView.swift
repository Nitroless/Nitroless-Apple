//
//  RepoView.swift
//  Keyboard
//
//  Created by Paras KCD on 2022-11-04.
//

import SwiftUI
import SDWebImageSwiftUI

struct RepoView: View {
    var kbv: KeyboardViewController
    @EnvironmentObject var repoMan: RepoManager
    
    var body: some View {
        ScrollView(.horizontal) {
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
                    
                    LazyHStack {
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
            .padding([.top, .horizontal], 20)
        }
        .frame(height: 240)
    }
    
    let rows = [
        GridItem(.adaptive(minimum: 45))
    ]
    
    @ViewBuilder
    var emotesGrid: some View {
        LazyHGrid(rows: rows) {
            let emotes = repoMan.selectedRepo!.repo.repoData!.emotes
            
            ForEach(0..<emotes.count, id: \.self) { i in
                let emote = emotes[i]
                
                let imgUrl = repoMan.selectedRepo!.repo.url
                    .appending(path: repoMan.selectedRepo!.repo.repoData!.path)
                    .appending(path: emote.name)
                    .appendingPathExtension(emote.type)
                
                Button {
                    kbv.textDocumentProxy.insertText(imgUrl.absoluteString)
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
