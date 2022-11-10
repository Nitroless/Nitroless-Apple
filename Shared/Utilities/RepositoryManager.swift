//
//  RepositoryManager.swift
//  Nitroless
//
//  Created by Lakhan Lothiyi on 29/09/2022.
//

import Foundation

class RepoManager: ObservableObject {
    let fileManager = FileManager.default
    
    @Published var repos: [Repo]
    @Published var frequentlyUsed: [URL]
    @Published var favouriteEmotes: [URL]
    @Published var selectedRepo: SelectedRepo?
    @Published var selectedEmote: String?
    
    init() {
        self.repos = []
        self.frequentlyUsed = []
        self.favouriteEmotes = []
        self.loadRepos()
        self.loadFrequentEmotes()
        self.loadFavouriteEmotes()
    }
    
    public func selectRepo(selectedRepo: SelectedRepo) {
        self.selectedRepo = selectedRepo
    }
    
    public func selectHome() {
        self.selectedRepo = nil
    }
    
    public func hasRepositories() -> Bool {
        let repositories = StorageManager.shared.s.repos
        return !repositories.isEmpty
    }
    
    public func removeFromFavourite(repo: String, emote: String) {
        guard let repoUrl = URL(string: repo) else { return }
        guard let emoteUrl = URL(string: emote) else { return }
        let hostname = repoUrl.host
        let faveDict = StorageManager.shared.s.favouriteEmotesPerRepo
        
        if var repoFaves = faveDict[hostname!] {
            repoFaves = repoFaves.filter({ url in
                url != emoteUrl
            })
            
            StorageManager.shared.s.favouriteEmotesPerRepo[hostname!] = repoFaves
        }
        
        StorageManager.shared.s.frequentEmotes.removeAll(where: { url in
            url == emoteUrl
        })
    }
    
    public func removeRepo(repo: URL) {
        
        var repositories = StorageManager.shared.s.repos
        
        repositories = repositories.filter { loopedRepo in
            loopedRepo != repo
        }
        
        StorageManager.shared.s.repos = repositories
        
        DispatchQueue.main.async {
            self.repos = []
            self.loadRepos()
        }
    }
    
    public func addToFavourites(repo: String, emote: String) -> Void {
        guard let repoUrl = URL(string: repo) else { return }
        guard let emoteURL = URL(string: emote) else {
            print("[AddToFavourites] Adding \"\(emote)\" failed, invalid URL")
            return
        }
        let hostname = repoUrl.host
        
        var repoFaves = StorageManager.shared.s.favouriteEmotesPerRepo[hostname!] ?? []
        var faves = StorageManager.shared.s.favouriteEmotes
        
        repoFaves.removeAll { url in
            url == emoteURL
        }
        repoFaves.insert(emoteURL, at: 0)
        
        faves.removeAll { url in
            url == emoteURL
        }
        faves.insert(emoteURL, at: 0)
        
        StorageManager.shared.s.favouriteEmotes = faves
        StorageManager.shared.s.favouriteEmotesPerRepo[hostname!] = repoFaves
        
        DispatchQueue.main.async {
            self.repos = []
            self.favouriteEmotes = []
            self.loadRepos()
            self.loadFavouriteEmotes()
        }
            
    }
    
    public func addToFrequentlyUsed(emote: String) -> Void {
        guard let emoteURL = URL(string: emote) else {
            print("[AddToFrequentlyUsed] Adding \"\(emote)\" failed, invalid URL")
            return
        }
        
        var freq = StorageManager.shared.s.frequentEmotes
        freq.removeAll { url in
            url == emoteURL
        }
        
        freq.insert(emoteURL, at: 0)
        
        //Check if frequently used emotes is above 50
        freq = Array(freq.prefix(50))
    
        StorageManager.shared.s.frequentEmotes = freq
        
        loadFrequentEmotes()
    }
    
    public func addRepo(repo: String) -> Bool {
        
        guard let repoUrl = URL(string: repo) else {
            print("[AddRepo] Adding \"\(repo)\" failed, invalid url")
            return false
        }
        
        StorageManager.shared.s.repos.append(repoUrl)
        
        // get data and add to repo list
        let url = repoUrl
        let index = url.appending(path: "index.json")
        let req = URLRequest(url: index)
        
        
        URLSession.shared.dataTask(with: req) { [self] data, res, err in
            
            guard err == nil && "\((res as! HTTPURLResponse).statusCode)".hasPrefix("20") else {
                let repo = Repo(url: url, repoData: nil, favouriteEmotes: nil)
                DispatchQueue.main.async {
                    self.repos.append(repo)
                    self.reorderRepos()
                }
                return
            }
            
            guard let data = data else {
                let repo = Repo(url: url, repoData: nil, favouriteEmotes: nil)
                DispatchQueue.main.async {
                    self.repos.append(repo)
                    self.reorderRepos()
                }
                return
            }
            
            do {
                let json = try JSONDecoder().decode(NitrolessRepo.self, from: data)
                
                let final = Repo(url: url, repoData: json, favouriteEmotes: nil)
                
                DispatchQueue.main.async {
                    self.repos.append(final)
                    self.reorderRepos()
                }
            } catch {
                print(error)
                
                let repo = Repo(url: url, repoData: nil, favouriteEmotes: nil)
                DispatchQueue.main.async {
                    self.repos.append(repo)
                    self.reorderRepos()
                }
                return
            }
        }
        .resume()
            
        return true
    }
    
    public func reorderRepos() {
        self.repos.sort { r1, r2 in
            if let r1data = r1.repoData, let r2data = r2.repoData {
                return r1data.name.lowercased() < r2data.name.lowercased()
            } else {
                return r1.url.absoluteString.lowercased() < r2.url.absoluteString.lowercased()
            }
        }
    }
    
    private func loadFavouriteEmotes() {
        
        var emotes = StorageManager.shared.s.favouriteEmotes
        
        for emote in emotes {
            self.favouriteEmotes.append(emote)
        }
    }
    
    private func loadFrequentEmotes() {
        self.frequentlyUsed = []
        self.frequentlyUsed = StorageManager.shared.s.frequentEmotes
    }
    
    private func loadRepos() {
        
        let repositories = StorageManager.shared.s.repos
                
        for repository in repositories {
            let url = repository
            let index = url.appending(path: "index.json")
            let req = URLRequest(url: index)
            
            URLSession.shared.dataTask(with: req) { [self] data, res, err in
                
                guard err == nil && "\((res as! HTTPURLResponse).statusCode)".hasPrefix("20") else {
                    let repo = Repo(url: url, repoData: nil, favouriteEmotes: nil)
                    DispatchQueue.main.async {
                        self.repos.append(repo)
                        self.reorderRepos()
                    }
                    return
                }
                
                guard let data = data else {
                    let repo = Repo(url: url, repoData: nil, favouriteEmotes: nil)
                    DispatchQueue.main.async {
                        self.repos.append(repo)
                        self.reorderRepos()
                    }
                    return
                }
                
                do {
                    let json = try JSONDecoder().decode(NitrolessRepo.self, from: data)
                    
                    let final = Repo(url: url, repoData: json, favouriteEmotes: favouriteEmotes)
                    
                    DispatchQueue.main.async {
                        self.repos.append(final)
                        self.reorderRepos()
                        
                        if self.selectedRepo != nil && self.selectedRepo!.repo.url == final.url {
                            self.selectedRepo = SelectedRepo(active: true, repo: final)
                        }
                    }
                } catch {
                    print(error)
                    
                    let repo = Repo(url: url, repoData: nil, favouriteEmotes: nil)
                    DispatchQueue.main.async {
                        self.repos.append(repo)
                        self.reorderRepos()
                    }
                    return
                }
            }
            .resume()
        }
    }
    
    public func getRepoData(url: URL) async throws -> Repo {
        let index = url.appending(path: "index.json")
        let req = URLRequest(url: index)
        let (data, _) = try await URLSession.shared.data(for: req)
        let repodata = try JSONDecoder().decode(NitrolessRepo.self, from: data)
        let repo = Repo(url: url, repoData: repodata, favouriteEmotes: nil)
        return repo
    }
    
    public func reloadRepos() {
        repos = []
        loadRepos()
    }
    
    public func reloadFrequentlyUsed() {
        loadFrequentEmotes()
    }
}

struct Repo {
    let url: URL
    let repoData: NitrolessRepo?
    let favouriteEmotes: [URL]?
}

struct SelectedRepo {
    let active: Bool
    let repo: Repo
}

// MARK: - NitrolessRepo
struct NitrolessRepo: Codable {
    let icon: String
    let author: String?
    let name, path: String
    let emotes: [NitrolessEmote]
}

// MARK: - NitrolessEmote
struct NitrolessEmote: Codable {
    let name, type: String
}

