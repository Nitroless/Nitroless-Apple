//
//  RepositoryManager.swift
//  Nitroless
//
//  Created by Lakhan Lothiyi on 29/09/2022.
//

import Foundation


class RepoManager: ObservableObject {
    @Published var repos: [Repo]
    
    init() {
        self.repos = []
        loadRepos()
    }
    
    public func removeRepo(repo: URL) {
        let file = FileLocations.repoList
        
        let fileExists = FileManager.default.fileExists(atPath: file.path)
        
        if !fileExists {
            try? "".write(to: file, atomically: true, encoding: String.Encoding.utf8)
        }
        
        let repoString = (try? String(contentsOf: file, encoding: .utf8))
        
        guard let repoString = repoString else { return }
        var repositories = repoString.components(separatedBy: "\n")
        
        if let e = repositories.first {
            if e.isEmpty {
                repositories = Array(repositories.dropFirst())
            }
        }
        
        repositories = repositories.filter { str in
            URL(string: str)! != repo
        }
        
        let final = repositories.joined(separator: "\n")
        try? final.write(to: file, atomically: true, encoding: String.Encoding.utf8)
        
        repos = []
        
        loadRepos()
    }
    
    public func addRepo(repo: String) -> Bool {
        
        guard let repoUrl = URL(string: repo) else {
            return false
        }
        
        let file = FileLocations.repoList
        
        let fileExists = FileManager.default.fileExists(atPath: file.path)
        
        if !fileExists {
            try? "".write(to: file, atomically: true, encoding: String.Encoding.utf8)
        }
        
        let repoString = (try? String(contentsOf: file, encoding: .utf8))
        
        guard let repoString = repoString else { return false }
        var repositories = repoString.components(separatedBy: "\n")
        
        if let e = repositories.first {
            if e.isEmpty {
                repositories = Array(repositories.dropFirst())
            }
        }
        
        repositories.append(repoUrl.absoluteString)
        
        // get data and add to repo list
        let url = repoUrl
        let req = URLRequest(url: url)
        URLSession.shared.dataTask(with: req) { [self] data, res, err in
            
            guard err == nil && "\((res as! HTTPURLResponse).statusCode)".hasPrefix("20") else {
                let repo = Repo(url: url, repoData: nil)
                repos.append(repo)
                return
            }
            
            guard let data = data else {
                let repo = Repo(url: url, repoData: nil)
                repos.append(repo)
                return
            }
            
            guard let json = try? JSONDecoder().decode(NitrolessRepo.self, from: data) else {
                let repo = Repo(url: url, repoData: nil)
                repos.append(repo)
                return
            }
            
            let final = Repo(url: url, repoData: json)
            
            repos.append(final)
        }
        .resume()
        
        let final = repositories.joined(separator: "\n")
        try? final.write(to: file, atomically: true, encoding: String.Encoding.utf8)
        
        return true
    }
    
    private func loadRepos() {

        let file = FileLocations.repoList
        
        let fileExists = FileManager.default.fileExists(atPath: file.path)
        
        if !fileExists {
            try? "".write(to: file, atomically: true, encoding: String.Encoding.utf8)
        }
        
        let repoString = (try? String(contentsOf: file, encoding: .utf8))
        
        guard let repoString = repoString else { return }
        var repositories = repoString.components(separatedBy: "\n")
        
        if let e = repositories.first {
            if e.isEmpty {
                repositories = Array(repositories.dropFirst())
            }
        }
                
        for repository in repositories {
            let url = URL(string: repository)!
            let req = URLRequest(url: url)
            URLSession.shared.dataTask(with: req) { [self] data, res, err in
                
                guard err == nil && "\((res as! HTTPURLResponse).statusCode)".hasPrefix("20") else {
                    let repo = Repo(url: url, repoData: nil)
                    repos.append(repo)
                    return
                }
                
                guard let data = data else {
                    let repo = Repo(url: url, repoData: nil)
                    repos.append(repo)
                    return
                }
                
                guard let json = try? JSONDecoder().decode(NitrolessRepo.self, from: data) else {
                    let repo = Repo(url: url, repoData: nil)
                    repos.append(repo)
                    return
                }
                
                let final = Repo(url: url, repoData: json)
                
                repos.append(final)
            }
            .resume()
        }
    }
}

struct Repo {
    let url: URL
    let repoData: NitrolessRepo?
}



// MARK: - NitrolessRepo
struct NitrolessRepo: Codable {
    let name, icon, path: String
    let emotes: [NitrolessEmote]
}

// MARK: - NitrolessEmote
struct NitrolessEmote: Codable {
    let name, type: String
}
