//
//  ContentViewModel.swift
//  Nitroless
//
//  Created by Paras KCD on 2022-10-08.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var repos = [Repo]()
    @Published var selectedRepo = Repo(active: false, url: "", emote: Emote(name: "", icon: "", path: "", emotes: [EmoteElement]()))
    @Published var isLoading = false
    @Published var isHomeActive = true
    
    init() {
        self.fetchRepos()
    }
    
    func selectRepo(selectedRepo: Repo) {
        self.selectedRepo = selectedRepo
    }
    
    func deselectRepo() {
        self.selectedRepo = Repo(active: false, url: "", emote: Emote(name: "", icon: "", path: "", emotes: [EmoteElement]()))
    }
    
    func getRepoFromUser(title: String, question: String, defaultValue: String) {
        let msg = NSAlert()
        msg.addButton(withTitle: "OK")      // 1st button
        msg.addButton(withTitle: "Cancel")  // 2nd button
        msg.messageText = title
        msg.informativeText = question

        let txt = NSTextField(frame: NSRect(x: 0, y: 0, width: 200, height: 24))
        txt.stringValue = defaultValue

        msg.accessoryView = txt
        let response: NSApplication.ModalResponse = msg.runModal()

        if (response == NSApplication.ModalResponse.alertFirstButtonReturn) {
            var url = txt.stringValue
            
            if txt.stringValue.last! != "/" {
                url = "\(txt.stringValue)/"
            }
            
            addToUserDefaults(url: url)
        } else {
            return
        }
    }
    
    func addToUserDefaults(url: String) {
        var repos = UserDefaults.standard.object(forKey:"repos") as? [String] ?? [String]()
        
        repos.append(url)
        
        UserDefaults.standard.set(repos, forKey: "repos")
        self.repos = [Repo]()
        
        self.fetchEmotes(urls: repos)
    }
    
    func removeFromUserDefaults(url: String) {
        var repos = UserDefaults.standard.object(forKey:"repos") as? [String] ?? [String]()
        
        repos = repos.filter({$0 != url})
        
        UserDefaults.standard.set(repos, forKey: "repos")
        
        self.repos = [Repo]()
        
        self.fetchEmotes(urls: repos)
    }
    
    func makeRepoActive(url: String) {
        let repos = self.repos
        var newRepos = [Repo]()
        
        for var repo in repos {
            repo.active = false
            if repo.url == url {
                repo.active = true
            }
            
            newRepos.append(repo)
        }
        
        DispatchQueue.main.async {
            self.repos = newRepos
            if self.isHomeActive == true {
                self.isHomeActive = false
            }
        }
        
    }
    
    func makeAllReposInactive() {
        let repos = self.repos
        var newRepos = [Repo]()
        
        for var repo in repos {
            if repo.active == true {
                repo.active = false
            }
            
            newRepos.append(repo)
        }
        
        DispatchQueue.main.async {
            self.repos = newRepos
            self.isHomeActive = true
        }
    }
    
    func fetchEmotes(urls: [String]) {
        DispatchQueue.main.async {
            for urlString in urls {
                guard let url = URL(string: "\(urlString)/index.json") else { continue }
                
                URLSession.shared.dataTask(with: url) {
                    data, response, error in
                    
                    if let error = error {
                        print("DEBUG: Error - \(error.localizedDescription)")
                        DispatchQueue.main.async {
                            self.isLoading = false
                        }
                        return
                    }
                    
                    if let response = response as? HTTPURLResponse {
                        print("DEBUG: Response Code - \(response.statusCode)")
                    }
                    
                    guard let data = data else { return }
                    
                    do {
                        let emote = try JSONDecoder().decode(Emote.self, from: data)
                        DispatchQueue.main.async {
                            let repo = Repo(active: false, url: urlString, emote: emote)
                            self.repos.append(repo)
                            self.isLoading = false
                        }
                    } catch let error {
                        print("DEBUG: Failed to decode because of Error - \(error)")
                        DispatchQueue.main.async {
                            self.isLoading = false
                        }
                    }

                }.resume()
            }
        }
    }
    
    func fetchRepos() {
        if UserDefaults.standard.object(forKey: "repos") == nil {
            guard let url = URL(string: "https://nitroless.github.io/default.json") else { return }
            let req = URLRequest(url: url)
            URLSession.shared.dataTask(with: req) {
                data, response, error in
                
                if let error = error {
                    print("DEBUG: Error - \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        self.isLoading = false
                    }
                    return
                }
                
                if let response = response as? HTTPURLResponse {
                    print("DEBUG: Response Code - \(response.statusCode)")
                }
                
                guard let data = data else { return }
                do {
                    let json = try JSONDecoder().decode([String].self, from: data)
                    UserDefaults.standard.set(json, forKey: "repos")
                    
                    self.fetchEmotes(urls: json)
                } catch let error {
                    print("DEBUG: Failed to decode because of Error - \(error)")
                    DispatchQueue.main.async {
                        self.isLoading = false
                    }
                }
            }.resume()
        } else {
            let array = UserDefaults.standard.object(forKey:"repos") as? [String] ?? [String]()
            self.fetchEmotes(urls: array)
        }
        
    }
}
