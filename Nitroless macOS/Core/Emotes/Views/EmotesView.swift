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
    
    var body: some View {
        if viewModel.selectedRepo.active == true {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    HStack {
                        WebImage(url: URL(string: "\(viewModel.selectedRepo.url)/\(viewModel.selectedRepo.emote.icon)"))
                            .resizable()
                            .frame(width: 48, height: 48)
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                            .shadow(radius: 5)
                        
                        Text("\(viewModel.selectedRepo.emote.name)")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .font(.title)
                    Spacer()
                    HStack(spacing: 1) {
                        Text("URL: ")
                        Link(viewModel.selectedRepo.url, destination: URL(string: viewModel.selectedRepo.url)!)
                            .foregroundColor(Color(red: 0.35, green: 0.40, blue: 0.95))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    Text("Number of Emotes: \(viewModel.selectedRepo.emote.emotes.count)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer(minLength: 10)
                    HStack {
                        Button {
                            viewModel.showToast = true
                            pasteboard.clearContents()
                            pasteboard.setString(String("Check out this awesome Repo \(viewModel.selectedRepo.emote.name) - \(viewModel.selectedRepo.url)"), forType: NSPasteboard.PasteboardType.string)
                        } label: {
                            HStack {
                                Image(systemName: "square.and.arrow.up.fill")
                                Text("Share")
                            }
                            .foregroundColor(self.hovered.image == "square.and.arrow.up.fill" && self.hovered.hover == true  ? Color(.white) : Color(red: 0.35, green: 0.40, blue: 0.95))
                            .padding(10)
                            .background(self.hovered.image == "square.and.arrow.up.fill" && self.hovered.hover == true ? Color(red: 0.35, green: 0.40, blue: 0.95) : Color(red: 0.21, green: 0.22, blue: 0.25))
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                            .animation(.spring(), value: self.hovered.hover)
                            .shadow(radius: 5)
                        }
                        .buttonStyle(.plain)
                        .onHover { isHovered in
                            self.hovered = Hovered(image: "square.and.arrow.up.fill", hover: isHovered)
                        }

                        Button {
                            viewModel.removeFromUserDefaults(url: viewModel.selectedRepo.url)
                            viewModel.deselectRepo()
                        } label: {
                            HStack {
                                Image(systemName: "minus.circle.fill")
                                Text("Remove")
                            }
                            .foregroundColor(self.hovered.image == "minus.circle.fill" && self.hovered.hover == true ? Color(.white) : Color(red: 0.93, green: 0.26, blue: 0.27))
                            .padding(10)
                            .background(self.hovered.image == "minus.circle.fill" && self.hovered.hover == true ? Color(red: 0.93, green: 0.26, blue: 0.27) : Color(red: 0.21, green: 0.22, blue: 0.25))
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                            .animation(.spring(), value: self.hovered.hover)
                            .shadow(radius: 5)
                        }
                        .buttonStyle(.plain)
                        .onHover { isHovered in
                            self.hovered = Hovered(image: "minus.circle.fill", hover: isHovered)
                        }
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(20)
                .background(Color(red: 0.13, green: 0.13, blue: 0.15).opacity(0.6))
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(red: 0.29, green: 0.30, blue: 0.33).opacity(0.4), lineWidth: 1)
                )
                
                VStack {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 50))]) {
                        ForEach (viewModel.selectedRepo.emote.emotes, id: \.name) {
                            emote in
                            EmoteView(url: viewModel.selectedRepo.url, path: viewModel.selectedRepo.emote.path, emote: emote, viewModel: viewModel)
                        }
                    }
                    .padding(20)
                    .background(Color(red: 0.13, green: 0.13, blue: 0.15).opacity(0.6))
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color(red: 0.29, green: 0.30, blue: 0.33).opacity(0.4), lineWidth: 1)
                    )
                }
                .padding(.bottom)
                
            }
            .padding([.top, .trailing])
            .padding(.leading, 6)
        } else {
            ScrollView {
                HomeView(viewModel: viewModel)
                    .padding([.top, .trailing])
                    .padding(.leading, 6)
            }
        }
        
    }
}
