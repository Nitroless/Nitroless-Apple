//
//  RepoView.swift
//  Nitroless
//
//  Created by Paras KCD on 2022-10-08.
//

import SwiftUI
import AppKit
import SDWebImageSwiftUI

struct RepoView: View {
    @StateObject var viewModel: ContentViewModel
    @State private var hovered = Hovered(image: "", hover: false)
    
    var body: some View {
        List {
            HStack {
                Rectangle()
                    .fill(.white)
                    .frame(width: 3, height: (viewModel.isHomeActive == true) || (self.hovered.image == "Icon" && self.hovered.hover == true) ? 32 : (viewModel.isHomeActive == false) && (self.hovered.image == "Icon" && self.hovered.hover == true) ? 8 : 0 )
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .animation(.spring(), value: self.hovered.hover && !viewModel.isHomeActive)
                
                Image("Icon")
                    .resizable()
                    .frame(width: 48, height: 48)
                    .clipShape(RoundedRectangle(cornerRadius: (viewModel.isHomeActive == true) || (self.hovered.image == "Icon" && self.hovered.hover == true) ? 8 : 99, style: .continuous))
                    .animation(.spring(), value: self.hovered.hover && !viewModel.isHomeActive)
                    .onHover { isHovered in
                        self.hovered = Hovered(image: "Icon", hover: isHovered)
                        DispatchQueue.main.async { //<-- Here
                            if (self.hovered.hover) {
                                NSCursor.pointingHand.push()
                            } else {
                                NSCursor.pop()
                            }
                        }
                    }
                    .shadow(radius: 5)
            }
            .onHover { isHovered in
                self.hovered = Hovered(image: "Icon", hover: isHovered)
                DispatchQueue.main.async { //<-- Here
                    if (self.hovered.hover) {
                        NSCursor.pointingHand.push()
                    } else {
                        NSCursor.pop()
                    }
                }
            }
            .onTapGesture {
                viewModel.makeAllReposInactive()
                viewModel.deselectRepo()
            }
            
            Divider()
                .frame(width: 40)
                .offset(x: 15)
            
            VStack {
                ForEach(viewModel.repos, id: \.url) {
                    repo in
                    HStack {
                        Rectangle()
                            .fill(.white)
                            .frame(width: 3, height: (self.hovered.image == "\(repo.url)/\(repo.emote.icon)" && self.hovered.hover == true) || (repo.active == true) ? 32 : (self.hovered.image == "\(repo.url)/\(repo.emote.icon)" && self.hovered.hover == true) && (repo.active == false) ? 8 : 0)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .animation(.spring(), value: self.hovered.hover && !repo.active)
                        
                        WebImage(url: URL(string: "\(repo.url)/\(repo.emote.icon)"))
                            .resizable()
                            .frame(width: 48, height: 48)
                            .clipShape(RoundedRectangle(cornerRadius: (self.hovered.image == "\(repo.url)/\(repo.emote.icon)" && self.hovered.hover == true) || (repo.active == true) ? 8 : 99, style: .continuous))
                            .animation(.spring(), value: self.hovered.hover && !repo.active)
                            .onHover { isHovered in
                                self.hovered = Hovered(image: "\(repo.url)/\(repo.emote.icon)", hover: isHovered)
                                DispatchQueue.main.async { //<-- Here
                                    if (self.hovered.hover) {
                                        NSCursor.pointingHand.push()
                                    } else {
                                        NSCursor.pop()
                                    }
                                }
                            }
                            .shadow(radius: 5)
                    }
                    .onHover { isHovered in
                        self.hovered = Hovered(image: "\(repo.url)/\(repo.emote.icon)", hover: isHovered)
                        DispatchQueue.main.async { //<-- Here
                            if (self.hovered.hover) {
                                NSCursor.pointingHand.push()
                            } else {
                                NSCursor.pop()
                            }
                        }
                    }
                    .onTapGesture {
                        viewModel.makeRepoActive(url: repo.url)
                        viewModel.selectRepo(selectedRepo: Repo(active: true, url: repo.url, emote: repo.emote))
                    }
                }
            }
            
            Divider()
                .frame(width: 40)
                .offset(x: 15)
            
            HStack {
                Rectangle()
                    .fill(.clear)
                    .frame(width: 3, height: 0)
                
                Image(systemName: "plus.app.fill")
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: (self.hovered.image == "plus.app.fill" && self.hovered.hover == true) ? 8 : 99, style: .continuous))
                    .background(RoundedRectangle(cornerRadius: 99, style: .continuous).fill((self.hovered.image == "plus.app.fill" && self.hovered.hover == true) ? .white : Color(red: 0.34, green: 0.95, blue: 0.53)).frame(width: 30, height: 30))
                    .foregroundColor((self.hovered.image == "plus.app.fill" && self.hovered.hover == true) ? Color(red: 0.34, green: 0.95, blue: 0.53) : Color(red: 0.21, green: 0.22, blue: 0.25))
                    .frame(width: 48, height: 48)
                    .animation(.spring(), value: (self.hovered.image == "plus.app.fill" && self.hovered.hover == true))
                    .onHover { isHovered in
                        self.hovered = Hovered(image: "plus.app.fill", hover: isHovered)
                        DispatchQueue.main.async { //<-- Here
                            if (self.hovered.hover) {
                                NSCursor.pointingHand.push()
                            } else {
                                NSCursor.pop()
                            }
                        }
                    }
                    .shadow(radius: 5)
            }
            .onHover { isHovered in
                self.hovered = Hovered(image: "plus.app.fill", hover: isHovered)
                DispatchQueue.main.async { //<-- Here
                    if (self.hovered.hover) {
                        NSCursor.pointingHand.push()
                    } else {
                        NSCursor.pop()
                    }
                }
            }
            .onTapGesture {
                viewModel.getRepoFromUser(title: "Add Repo", question: "Enter Repo URL Here", defaultValue: "")
            }
        }
        .removeBackground()
        .frame(width: 78)
    }
}
