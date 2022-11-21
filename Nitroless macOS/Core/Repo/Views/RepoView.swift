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
    @ObservedObject var AppKitEventsObj = AppKitEvents.shared
        
    var body: some View {
        ScrollView(showsIndicators: false) {
            ZStack {
                HStack{
                    Rectangle()
                        .fill(Color.theme.textColor)
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
                }
                HStack {
                    TriangleShape()
                        .fill(.black)
                        .frame(width: 20, height: 15)
                        .offset(y: 15)
                        .rotationEffect(.degrees(-90))
                    
                    Text("Home")
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 8).fill(.black))
                }
                .opacity(self.hovered.image == "Icon" && self.hovered.hover == true ? 1 : 0)
                .offset(x: 50)
                .animation(.spring(), value: self.hovered.hover)
                .foregroundColor(Color.white)
            }
            .frame(width: 150)
            .padding([.top, .leading, .trailing])
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
                .offset(x: 5)
            
            VStack {
                ForEach(viewModel.repos, id: \.url) {
                    repo in
                    ZStack {
                        HStack {
                            Rectangle()
                                .fill(Color.theme.textColor)
                                .frame(width: 3, height: (self.hovered.image == "\(repo.url)/\(repo.emote.icon)" && self.hovered.hover == true) || (repo.active == true) ? 32 : (self.hovered.image == "\(repo.url)/\(repo.emote.icon)" && self.hovered.hover == true) && (repo.active == false) ? 8 : 0)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .animation(.spring(), value: self.hovered.hover && !repo.active)
                            
                            WebImage(url: URL(string: "\(repo.url)/\(repo.emote.icon)"))
                                .resizable()
                                .placeholder {
                                    ProgressView()
                                }
                                .frame(width: 48, height: 48)
                                .background(Color.theme.appBGColor.opacity(0.6))
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
                            viewModel.selectRepo(selectedRepo: Repo(active: true, url: repo.url, favouriteEmotes: repo.favouriteEmotes, emote: repo.emote))
                        }
                        
                        HStack {
                            TriangleShape()
                                .fill(.black)
                                .frame(width: 20, height: 15)
                                .offset(y: 15)
                                .rotationEffect(.degrees(-90))
                            
                            Text(repo.emote.name.prefix(5))
                                .padding(10)
                                .background(RoundedRectangle(cornerRadius: 8).fill(.black))
                        }
                        .opacity(self.hovered.image == "\(repo.url)/\(repo.emote.icon)" && self.hovered.hover == true ? 1 : 0)
                        .offset(x: 50)
                        .animation(.spring(), value: self.hovered.hover)
                        .foregroundColor(Color.white)
                    }
                    
                }
            }
            .padding(.horizontal)
            
            Divider()
                .frame(width: 40)
                .offset(x: 5)
            
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
            }
            .padding(.horizontal)
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
            .onReceive(AppKitEventsObj.receivedUrl.publisher) { _ in
                guard let url = AppKitEventsObj.receivedUrl else { return }
                AppKitEvents.shared.receivedUrl = nil
                handleUrl(url)
            }
        }
        .frame(width: 64)
    }
    
    func handleUrl(_ url: URL) {
        var str = url.absoluteString
        str = str.replacingOccurrences(of: "nitroless://", with: "https://nitroless.github.io/")
        let comp = URLComponents(string: str)!
        let path = comp.path.dropFirst()
        
        switch path {
        case "add-repository":
            guard let urlparam = comp.queryItems?.filter({ item in item.name == "url"}).first else { return }
            guard let urlToAdd = urlparam.value else { return }
            
            let repos = UserDefaults.standard.object(forKey:"repos") as? [String] ?? [String]()
            
            let msg = NSAlert()
            msg.addButton(withTitle: "OMG! I didn't know, I'm so stupid, sorry!")      // 1st button
            msg.messageText = "Repo already added!"
            msg.informativeText = "Repo is already added, why add again bro?"
            
            if repos.contains(urlToAdd) || repos.contains(urlToAdd + "/") {
                let response: NSApplication.ModalResponse = msg.runModal()
                
                if response == NSApplication.ModalResponse.alertFirstButtonReturn {
                    return
                }
            } else {
                viewModel.getRepoFromUser(title: "Add Repo", question: "Enter Repo URL Here", defaultValue: urlToAdd)
            }
            
        default:
            return;
        }
    }
}
