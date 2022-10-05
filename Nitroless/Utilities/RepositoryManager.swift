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
        
        DispatchQueue.main.async {
            self.repos = []
        }
        
        loadRepos()
    }
    
    public func addRepo(repo: String) -> Bool {
        
        guard let repoUrl = URL(string: repo) else {
            print("[AddRepo] Adding \"\(repo)\" failed, invalid url")
            return false
        }
        
        let file = FileLocations.repoList
        
        let fileExists = FileManager.default.fileExists(atPath: file.path)
        
        if !fileExists {
            try? "".write(to: file, atomically: true, encoding: String.Encoding.utf8)
        }
        
        let repoString: String = (try? String(contentsOf: file, encoding: .utf8)) ?? ""
        
        var repositories = repoString.components(separatedBy: "\n")
        
        if let e = repositories.first {
            if e.isEmpty {
                repositories = Array(repositories.dropFirst())
            }
        }
        
        repositories.append(repoUrl.absoluteString)
        
        // get data and add to repo list
        let url = repoUrl
        let index = url.appending(path: "index.json")
        let req = URLRequest(url: index)
        
        let final = repositories.joined(separator: "\n")
        
        do {
            try final.write(to: file, atomically: true, encoding: String.Encoding.utf8)
            
            URLSession.shared.dataTask(with: req) { [self] data, res, err in
                
                guard err == nil && "\((res as! HTTPURLResponse).statusCode)".hasPrefix("20") else {
                    let repo = Repo(url: url, repoData: nil)
                    DispatchQueue.main.async {
                        self.repos.append(repo)
                    }
                    return
                }
                
                guard let data = data else {
                    let repo = Repo(url: url, repoData: nil)
                    DispatchQueue.main.async {
                        self.repos.append(repo)
                    }
                    return
                }
                
                do {
                    let json = try JSONDecoder().decode(NitrolessRepo.self, from: data)
                    
                    let final = Repo(url: url, repoData: json)
                    
                    DispatchQueue.main.async {
                        self.repos.append(final)
                    }
                } catch {
                    print(error)
                    
                    let repo = Repo(url: url, repoData: nil)
                    DispatchQueue.main.async {
                        self.repos.append(repo)
                    }
                    return
                }
            }
            .resume()
            
            return true
        } catch {
            print("[AddRepo] Adding \"\(repo)\" failed, couldn't save to repos file")
            
            return false
        }
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
        
//        repositories.append("https://lillieh001.github.io/nitroless/")
                
        for repository in repositories {
            let url = URL(string: repository)!
            let index = url.appending(path: "index.json")
            let req = URLRequest(url: index)
            URLSession.shared.dataTask(with: req) { [self] data, res, err in
                
                guard err == nil && "\((res as! HTTPURLResponse).statusCode)".hasPrefix("20") else {
                    let repo = Repo(url: url, repoData: nil)
                    DispatchQueue.main.async {
                        self.repos.append(repo)
                    }
                    return
                }
                
                guard let data = data else {
                    let repo = Repo(url: url, repoData: nil)
                    DispatchQueue.main.async {
                        self.repos.append(repo)
                    }
                    return
                }
                
                // hacky fixes for older repos if you want it
//                var str = String(data: data, encoding: .utf8)!
//                str = str.replacingOccurrences(of: "\"type\": \".", with: "\"type\": \"")
//                data = str.data(using: .utf8)!
                //end of hacky fix
                
                do {
                    let json = try JSONDecoder().decode(NitrolessRepo.self, from: data)
                    
                    let final = Repo(url: url, repoData: json)
                    
                    DispatchQueue.main.async {
                        self.repos.append(final)
                    }
                } catch {
                    print(error)
                    
                    let repo = Repo(url: url, repoData: nil)
                    DispatchQueue.main.async {
                        self.repos.append(repo)
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
        let repo = Repo(url: url, repoData: repodata)
        return repo
    }
}

struct Repo {
    var url: URL
    var repoData: NitrolessRepo?
}



// MARK: - NitrolessRepo
struct NitrolessRepo: Codable {
    var icon: String//?
    var name, path: String
    var emotes: [NitrolessEmote]
}

// MARK: - NitrolessEmote
struct NitrolessEmote: Codable {
    var name, type: String
}

