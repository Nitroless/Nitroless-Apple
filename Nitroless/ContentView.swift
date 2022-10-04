//
//  ContentView.swift
//  Nitroless
//
//  Created by Lakhan Lothiyi on 29/09/2022.
//

import SwiftUI
import SDWebImageSwiftUI
import SDWebImageWebPCoder
import AlertToast

struct ContentView: View {
    
    @EnvironmentObject var repoMan: RepoManager
    
    @State var urlToDelete: URL? = nil
    @State var showDeletePrompt = false
    
    @State var urlToAdd: String = ""
    @State var showAddPrompt = false
    @State var urlInvalidError = false
    
    @State var toastShown = false
    
    @State var showDefaultReposMenu = false
    
    @State var sheetDetent: PresentationDetent = .medium
    
    var body: some View {
        NavigationStack {
            List {
                if repoMan.repos.isEmpty {
                    Button {
                        showDefaultReposMenu = true
                    } label: {
                        Label("Add Default Repos", systemImage: "globe")
                    }
                }
                
                ForEach(repoMan.repos, id: \.url) { repo in
                    repoButton(repo: repo)
                }
            }
            .sheet(isPresented: $showDefaultReposMenu) {
                AddDefaultRepos(isShown: $showDefaultReposMenu, detent: $sheetDetent)
                    .presentationDetents([.fraction(0.3), .large], selection: $sheetDetent.animation(.easeInOut(duration: 0.2)))
            }
            .toolbar {
                HStack {
                    
                    Button {
                        showDefaultReposMenu = true
                    } label: {
                        Image(systemName: "globe")
                    }

                    
                    Spacer()
                    
                    Button {
                        showAddPrompt = true
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                }
            }
            .navigationTitle("Nitroless")
            .confirmationDialog("Delete this broken repository?", isPresented: $showDeletePrompt, titleVisibility: .visible) {
                Button("Delete", role: .destructive) {
                    repoMan.removeRepo(repo: urlToDelete!)
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
                
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Please enter the URL of a Nitroless Repository")
            }
            .alert("Invalid URL", isPresented: $urlInvalidError) {
                Button("Dismiss", role: .cancel) {}
            } message: {
                Text("Please check the URL and try again.")
            }
            .onOpenURL { url in
                handleUrl(url)
            }
            
        }
        .toast(isPresenting: $toastShown, alert: {
            AlertToast(displayMode: .hud, type: .systemImage("checkmark", .green), title: "Copied!")
        })
    }
    
    func handleUrl(_ url: URL) {
        var str = url.absoluteString
        str = str.replacingOccurrences(of: "nitroless://", with: "https://nitroless.github.io/")
        let comp = URLComponents(string: str)!
        let path = comp.path.dropFirst()
        
        switch path {
        case "add-repository":
            guard let urlparam = comp.queryItems?.filter({ item in item.name == "url"}).first else { return }
            guard let param = urlparam.value else { return }
            
            urlToAdd = param
            showAddPrompt = true
        default:
            return;
        }
    }
    
    @ViewBuilder
    func repoButton(repo: Repo) -> some View {
        if let data = repo.repoData {
            NavigationLink {
                RepoView(toastShown: $toastShown, repo: repo)
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

struct AddDefaultRepos: View {
    @Binding var isShown: Bool
    @Binding var detent: PresentationDetent
    
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var repoMan: RepoManager
    
    var body: some View {
        switch detent {
        case .fraction(0.3):
            ask
        case .large:
            page
        default:
            ask
        }
    }
    
    @ViewBuilder
    var ask: some View {
        VStack {
            HStack(alignment: .center) {
                Image(systemName: "globe")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 75)
                    .padding(.trailing)
                Text("Default\nRepositories")
                    .font(.title.bold())
            }
            .padding(.top)
            
            Spacer()
            
            Text(
                repoMan.repos.isEmpty ? "Your repository list is looking a little empty, want to add some to start off with?" : "Want to look at Nitroless-provided repositories?"
            )
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Spacer()
            
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    detent = .large
                }
            } label: {
                Text("Browse")
                    .font(.title2)
            }
            .buttonStyle(.bordered)
        }
    }
    
    @ViewBuilder
    var page: some View {
        ScrollView {
            HStack {
                Text("Our Repositories")
                    .font(.title)
                    .bold()
                Spacer()
            }
            .padding(.leading)
            
            DefaultRepoCell(url: URL(string: "https://lillieh001.github.io/nitroless")!)
        }
        .safeAreaInset(edge: .top) {
            HStack {
                Button {
                    isShown.toggle()
                    detent = .fraction(0.3)
                } label: {
                    Circle()
                        .foregroundColor(.secondary)
                        .brightness(colorScheme == .light ? 0 : -0.6)
                        .overlay(content: {
                            Text("X")
                                .foregroundColor(.white)
                        })
                        .frame(width: 30, height: 30)
                }
                .buttonStyle(.plain)
                
                Spacer()
            }
            .padding()
        }
    }
}

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
                    }
                } else {
                    Rectangle()
                        .foregroundColor(.secondary)
                        .brightness(cs == .light ? 0.6 : -0.8)
                }
            }
            
            Group {
                // main content
                
                if let data = data {
                    HStack {
                        if let repoData = data.repoData {
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
                        
                        VStack(alignment: .leading) {
                            Text(url.host() ?? "Unknown")
                            
                            if let repoData = data.repoData {
                                Text("\(repoData.emotes.count) emote\(repoData.emotes.count == 1 ? "" : "s")")
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                            } else {
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
                                        Capsule()
                                            .foregroundColor(.init(white: cs == .light ? 0.95 : 0.12))
                                    }
                            }
                        }
                        .disabled(isAdded)
                        .padding(10)
                    }
                    .frame(height: 80)
                } else {
                    HStack {
                        Image(systemName: "questionmark.app.dashed")
                            .resizable()
                            .scaledToFit()
                            .padding(10)
                        
                        VStack(alignment: .leading) {
                            Text(url.host() ?? "Unknown")
                            Text("Could not access this repository")
                                .font(.caption2)
                                .foregroundColor(.secondary)
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
                                        Capsule()
                                            .foregroundColor(.init(white: 0.95))
                                    }
                            }
                        }
                        .disabled(isAdded)
                        .padding(10)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 80)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal)
        .task {
            let reposUrls: [URL] = repoMan.repos.compactMap { repo in return repo.url }
            if reposUrls.contains(url) {
                isAdded = true
            } else {
                isAdded = false
            }
            data = try? await repoMan.getRepoData(url: url)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RepoAddButtonTest()
            .environmentObject(RepoManager())
    }
}

struct RepoAddButtonTest: View {
    var body: some View {
        VStack {
            DefaultRepoCell(url: URL(string: "https://lillieh001.github.io/nitroless")!)
            DefaultRepoCell(url: URL(string: "https://lillieh001.github.io/nitroless")!)
            DefaultRepoCell(url: URL(string: "https://lillieh001.github.io/nitroless")!)
        }
    }
}

struct DefaultRepoTest: View {
    @State var detent: PresentationDetent = .fraction(0.3)
    @State var sheet = false
    var body: some View {
        Button("Open Sheet") {
            sheet.toggle()
        }
        .onAppear {
            sheet.toggle()
        }
        .sheet(isPresented: $sheet) {
            AddDefaultRepos(isShown: $sheet, detent: $detent)
                .presentationDetents([.fraction(0.3), .large], selection: $detent.animation(.easeInOut(duration: 0.2)))
        }
    }
}
