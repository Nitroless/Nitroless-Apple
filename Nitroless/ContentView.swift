//
//  ContentView.swift
//  Nitroless
//
//  Created by Lakhan Lothiyi on 29/09/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    
    @StateObject var repoMan = RepoManager()
    
    @State var urlToDelete: URL? = nil
    @State var showDeletePrompt = false
    
    @State var urlToAdd: String = ""
    @State var showAddPrompt = false
    @State var urlInvalidError = false
    
    var body: some View {
        NavigationStack {
            List {
                if repoMan.repos.isEmpty {
                    #warning("TODO: Add default repositories button")
                }
                
                ForEach(repoMan.repos, id: \.url) { repo in
                    repoButton(repo: repo)
                }
            }
            .navigationTitle("Nitroless")
            .confirmationDialog("Delete this broken repository?", isPresented: $showDeletePrompt, titleVisibility: .visible) {
                Button("Delete", role: .destructive) {
                    repoMan.removeRepo(repo: urlToDelete!)
                }
            }
            .toolbar {
                HStack {
                    Spacer()
                    Button {
                        showAddPrompt = true
                    } label: {
                        Image(systemName: "plus.circle")
                    }

                }
                .alert("Add Repository", isPresented: $showAddPrompt) {
                    TextField("Repository URL", text: $urlToAdd)
                    
                    Button("Add", role: .none) {
                        if let url = URL(string: urlToAdd) {
                            if repoMan.addRepo(repo: url.absoluteString) {} else {
                                urlInvalidError = true
                            }
                        } else {
                            urlInvalidError = true
                        }
                    }
                    
                    Button("Cancel", role: .cancel) {
                        if let url = URL(string: urlToAdd) {
                            if repoMan.addRepo(repo: url.absoluteString) {} else {
                                urlInvalidError = true
                            }
                        } else {
                            urlInvalidError = true
                        }
                    }
                } message: {
                    Text("Please enter the URL of a Nitroless Repository")
                }
                .alert("Invalid URL", isPresented: $urlInvalidError) {
                    Button("Dismiss", role: .cancel) {}
                } message: {
                    Text("Please check the URL and try again.")
                }

            }
        }
    }
    
    
    
    @ViewBuilder
    func repoButton(repo: Repo) -> some View {
        if let data = repo.repoData {
            NavigationLink {
                RepoView(repo: repo, url: repo.url)
            } label: {
                let imgUrl = repo.url.appending(path: data.icon)
                WebImage(url: imgUrl)
                    .resizable()
                    .placeholder {
                        ProgressView()
                    }
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 30)
                    .clipShape(Circle())
                Text(data.name)
            }
            .swipeActions(allowsFullSwipe: true) {
                Button {
                    repoMan.removeRepo(repo: repo.url)
                } label: {
                    Image(systemName: "trash")
                }
                .tint(.red)
            }
        } else {
            Button {
                urlToDelete = repo.url
                showDeletePrompt = true
            } label: {
                HStack {
                    Text(repo.url.absoluteString)
                    Spacer()
                    Image(systemName: "x.circle.fill")
                        .foregroundColor(.red)
                        .offset(x: 5)
                }
            }
            .swipeActions(allowsFullSwipe: true) {
                Button {
                    repoMan.removeRepo(repo: repo.url)
                } label: {
                    Image(systemName: "trash")
                }
                .tint(.red)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
