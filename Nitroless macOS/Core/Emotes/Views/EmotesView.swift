//
//  EmotesView.swift
//  Nitroless
//
//  Created by Paras KCD on 2022-10-08.
//

import SwiftUI
import SDWebImageSwiftUI

struct EmotesView: View {
    @StateObject var viewModel: ContentViewModel
    @State var hovered = Hovered(image: "", hover: false) 
    let pasteboard = NSPasteboard.general
    @State private var showPicker = false
    let delegate = NSApplication.shared.delegate as! AppDelegate
    
    var body: some View {
        if viewModel.selectedRepo.active == true {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    Button {
                        NSWorkspace.shared.open(URL(string: viewModel.selectedRepo.url)!)
                    } label: {
                        HStack {
                            WebImage(url: URL(string: "\(viewModel.selectedRepo.url)/\(viewModel.selectedRepo.emote.icon)"))
                                .resizable()
                                .placeholder {
                                    ProgressView()
                                }
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 48)
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading) {
                                Text(viewModel.selectedRepo.emote.name)
                                    .font(.custom("Uni Sans", size: 20))
                                if let author = viewModel.selectedRepo.emote.author {
                                    Text("By \(author)")
                                        .font(.footnote)
                                        .foregroundColor(.secondary)
                                }
                            }
                            Spacer()
                            Text("\(viewModel.selectedRepo.emote.emotes.count) emotes")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                    }
                    .buttonStyle(.plain)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(20)
                .background(Color.theme.appBGTertiaryColor.opacity(0.6))
                .cornerRadius(20)
                .overlay(RoundedRectangle(cornerRadius: 20).strokeBorder(Color(red: 0.29, green: 0.30, blue: 0.33).opacity(0.4), lineWidth: 1))
                
                if viewModel.selectedRepo.favouriteEmotes != nil && !viewModel.selectedRepo.favouriteEmotes!.isEmpty {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "star")
                            Text("Favourite Emotes")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .font(.headline)
                        
                        Spacer()
                        
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 35))]) {
                            ForEach (viewModel.selectedRepo.favouriteEmotes!, id: \.self) {
                                emote in
                                EmoteView(url: nil, path: nil, emote: nil, viewModel: viewModel, favouriteEmote: emote)
                                    .contextMenu {
                                        let viewModel: ContentViewModel = viewModel
                                        
                                        Divider()
                                        
                                        Button {
                                            viewModel.showToast = true
                                            pasteboard.clearContents()
                                            pasteboard.setString(String(emote), forType: NSPasteboard.PasteboardType.string)
                                            viewModel.addToFrequentlyUsedEmotes(frequentEmote: emote)
                                        } label: {
                                            Label("Copy", image: "doc.on.doc")
                                        }
                                        
                                        if #available(macOS 12.0, *) {
                                            Button(role: .destructive) {
                                                viewModel.removeFromFavouriteEmotes(repo: viewModel.selectedRepo.url, favouriteEmote: emote)
                                            } label: {
                                                Label("Remove from Favourites", image: "star")
                                            }
                                        } else {
                                            Button {
                                                viewModel.removeFromFavouriteEmotes(repo: viewModel.selectedRepo.url, favouriteEmote: emote)
                                            } label: {
                                                Label("Remove from Favourites", image: "star")
                                            }
                                        }
                                    }
                            }
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding(20)
                    .background(Color.theme.appBGSecondaryColor.opacity(0.6))
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .strokeBorder(Color(red: 0.29, green: 0.30, blue: 0.33).opacity(0.4), lineWidth: 1)
                        )
                }
                
                VStack {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 35))]) {
                        ForEach (viewModel.selectedRepo.emote.emotes, id: \.name) {
                            emote in
                            EmoteView(url: viewModel.selectedRepo.url, path: viewModel.selectedRepo.emote.path, emote: emote, viewModel: viewModel, favouriteEmote: nil)
                                .contextMenu {
                                    let pasteboard = NSPasteboard.general
                                    let url: String = viewModel.selectedRepo.url
                                    let path: String = viewModel.selectedRepo.emote.path
                                    let emote: EmoteElement = emote
                                    let viewModel: ContentViewModel = viewModel
                                    
                                    Text("\(emote.name)")
                                    
                                    Divider()
                                    
                                    Button {
                                        viewModel.showToast = true
                                        pasteboard.clearContents()
                                        pasteboard.setString(String("\(url)\(path == "" ? "" : "\(path)/")\(emote.name).\(emote.type)"), forType: NSPasteboard.PasteboardType.string)
                                        viewModel.addToFrequentlyUsedEmotes(frequentEmote: "\(url)\(path == "" ? "" : "\(path)/")\(emote.name).\(emote.type)")
                                    } label: {
                                        Label("Copy", image: "doc.on.doc")
                                    }
                                    
                                    if #available(macOS 12.0, *) {
                                        Button(role: viewModel.selectedRepo.favouriteEmotes != nil && viewModel.selectedRepo.favouriteEmotes!.count > 0 && viewModel.selectedRepo.favouriteEmotes!.contains(where: { emoteURL in
                                            emoteURL == "\(url)\(path == "" ? "" : "\(path)/")\(emote.name).\(emote.type)"
                                        }) ? .destructive : .none) {
                                            if viewModel.selectedRepo.favouriteEmotes != nil && viewModel.selectedRepo.favouriteEmotes!.count > 0 && viewModel.selectedRepo.favouriteEmotes!.contains(where: { emoteURL in
                                                emoteURL == "\(url)\(path == "" ? "" : "\(path)/")\(emote.name).\(emote.type)"
                                            }) {
                                                viewModel.removeFromFavouriteEmotes(repo: url, favouriteEmote: "\(url)\(path == "" ? "" : "\(path)/")\(emote.name).\(emote.type)")
                                            } else {
                                                viewModel.addToFavouriteEmotes(repo: url, favouriteEmote: "\(url)\(path == "" ? "" : "\(path)/")\(emote.name).\(emote.type)")
                                            }
                                        } label: {
                                            Label(viewModel.selectedRepo.favouriteEmotes != nil && viewModel.selectedRepo.favouriteEmotes!.count > 0 && viewModel.selectedRepo.favouriteEmotes!.contains(where: { emoteURL in
                                                emoteURL == "\(url)\(path == "" ? "" : "\(path)/")\(emote.name).\(emote.type)"
                                            }) ? "Remove from Favourites" : "Add to Favourites", image: "star")
                                        }
                                    } else {
                                        Button {
                                            if viewModel.selectedRepo.favouriteEmotes != nil && viewModel.selectedRepo.favouriteEmotes!.count > 0 && viewModel.selectedRepo.favouriteEmotes!.contains(where: { emoteURL in
                                                emoteURL == "\(url)\(path == "" ? "" : "\(path)/")\(emote.name).\(emote.type)"
                                            }) {
                                                viewModel.removeFromFavouriteEmotes(repo: url, favouriteEmote: "\(url)\(path == "" ? "" : "\(path)/")\(emote.name).\(emote.type)")
                                            } else {
                                                viewModel.addToFavouriteEmotes(repo: url, favouriteEmote: "\(url)\(path == "" ? "" : "\(path)/")\(emote.name).\(emote.type)")
                                            }
                                        } label: {
                                            Label(viewModel.selectedRepo.favouriteEmotes != nil && viewModel.selectedRepo.favouriteEmotes!.count > 0 && viewModel.selectedRepo.favouriteEmotes!.contains(where: { emoteURL in
                                                emoteURL == "\(url)\(path == "" ? "" : "\(path)/")\(emote.name).\(emote.type)"
                                            }) ? "Remove from Favourites" : "Add to Favourites", image: "star")
                                        }
                                    }
                                }
                        }
                    }
                    .padding(20)
                    .background(Color.theme.appBGSecondaryColor.opacity(0.6))
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .strokeBorder(Color(red: 0.29, green: 0.30, blue: 0.33).opacity(0.4), lineWidth: 1)
                        )
                }
                .padding(.bottom)
                
            }
            .padding(.trailing, 40)
            .padding(.leading, 10)
            
        } else {
            ScrollView(showsIndicators: false) {
                HomeView(viewModel: viewModel)
                    .padding(.trailing, 40)
                    .padding(.leading, 10)
                    
            }
            
        }
        
    }
}
