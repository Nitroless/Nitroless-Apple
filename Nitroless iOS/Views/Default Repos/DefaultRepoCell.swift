//
//  DefaultRepoCell.swift
//  Nitroless iOS
//
//  Created by Lakhan Lothiyi on 08/10/2022.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct DefaultRepoCell: View {
    
    @Environment(\.colorScheme) var cs
    @EnvironmentObject var repoMan: RepoManager
    
    var url: URL
    @State var data: Repo? = nil
    @State var isAdded = false
    
    var body: some View {
        ZStack {
            Group {
                // background blur
                if let data = data {
                    if data.repoData != nil {
                        let imgUrl = data.url.appending(path: data.repoData!.icon)
                        
                        WebImage(url: imgUrl)
                            .resizable()
                            .scaledToFill()
                            .blur(radius: 40)
                            .brightness(cs == .light ? 0 : -0.5)
                            .allowsHitTesting(false)
                    }
                } else {
                    Rectangle()
                        .foregroundColor(.secondary)
                        .brightness(cs == .light ? -0.1 : -0.8)
                        .allowsHitTesting(false)
                }
            }
            
            Group {
                // main content
                HStack {
                    if let repoData = data?.repoData {
                        let imgurl = url.appending(path: repoData.icon)
                        WebImage(url: imgurl)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .padding(10)
                    } else {
                        Image(systemName: "questionmark.app.dashed")
                            .resizable()
                            .scaledToFit()
                            .padding(10)
                    }
                    
                    if let repoData = data?.repoData {
                        VStack(alignment: .leading) {
                            Text(repoData.name)
                            
                            if let author = repoData.author {
                                Text("By \(author)")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            }
                            
                            Text("\(repoData.emotes.count) emote\(repoData.emotes.count == 1 ? "" : "s")")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                    } else {
                        VStack(alignment: .leading) {
                            Text(url.host() ?? "Unknown")
                            
                            Text("Could not access this repository")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                        addBtn()
                    } label: {
                        if isAdded {
                            Image(systemName: "checkmark.circle")
                                .resizable()
                                .foregroundColor(.green)
                                .scaledToFit()
                                .padding()
                        } else {
                            Text("add")
                                .lineLimit(1)
                                .textCase(.uppercase)
                                .bold()
                                .foregroundColor(.blue)
                                .padding(5)
                                .padding(.horizontal, 20)
                                .background {
                                    if data != nil {
                                        Capsule()
                                            .foregroundColor(.init(white: cs == .light ? 0.95 : 0.12))
                                    } else {
                                        Capsule()
                                            .foregroundColor(.init(white: 0.95))
                                    }
                                }
                        }
                    }
                    .disabled(isAdded)
                    .padding(10)
                }
                .frame(height: 80)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 80)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal)
        .shadow(radius: 4)
        .task {
            let reposUrls: [URL] = repoMan.repos.compactMap { repo in return repo.url }
            if reposUrls.contains(url) {
                isAdded = true
            } else {
                isAdded = false
            }
            do {
                data = try await repoMan.getRepoData(url: url)
            } catch {
                print(error)
            }
        }
    }
    
    func addBtn() {
        guard isAdded == false else { return }
        if repoMan.addRepo(repo: url.absoluteString) {
            withAnimation(.easeInOut(duration: 0.2)) {
                isAdded = true
            }
        }
    }
}
