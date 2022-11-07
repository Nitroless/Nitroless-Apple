//
//  ContentViewModel.swift
//  Nitroless
//
//  Created by Paras KCD on 2022-10-08.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var repos = [Repo]()
    @Published var selectedRepo = Repo(active: false, url: "", favouriteEmotes: [String](), emote: Emote(name: "", icon: "", path: "", author: "", emotes: [EmoteElement]()))
    @Published var frequentlyUsedEmotes = [String]()
    @Published var favouriteEmotes = [String]()
    @Published var isLoading: Bool = false
    @Published var isHomeActive: Bool = true
    @Published var isAboutActive: Bool = false
    @Published var isAnimating: Bool = false
    @Published var showToast: Bool = false;
    
    init() {
        Task {
            self.fetchRepos()
        }
        Task {
            self.fetchFrequentlyUsedEmotes()
        }
        Task {
            self.fetchFavouriteEmotes()
        }
    }
    
    func allowAnimation() {
        self.isAnimating = true
    }
    
    func killAnimation() {
        self.isAnimating = false
    }
    
    func selectRepo(selectedRepo: Repo) {
        self.selectedRepo = selectedRepo
    }
    
    func deselectRepo() {
        self.selectedRepo = Repo(active: false, url: "", favouriteEmotes: [String](), emote: Emote(name: "", icon: "", path: "", author: "", emotes: [EmoteElement]()))
    }
    
    func askBeforeExiting() {
        let delegate = NSApplication.shared.delegate as! AppDelegate
        delegate.popMenubarView()
        
        let msg = NSAlert()
        msg.addButton(withTitle: "Yes")
        msg.addButton(withTitle: "No")
        msg.messageText = "Quit Nitroless"
        msg.informativeText = "Want to quit Nitroless?"
        
        let response: NSApplication.ModalResponse = msg.runModal()
        
        if (response == NSApplication.ModalResponse.alertFirstButtonReturn) {
            NSApplication.shared.terminate(self)
        } else {
            return
        }
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
        
        let delegate = NSApplication.shared.delegate as! AppDelegate
        delegate.popMenubarView()
        
        let response: NSApplication.ModalResponse = msg.runModal()

        if (response == NSApplication.ModalResponse.alertFirstButtonReturn) {
            let urlStr = txt.stringValue
            let url = URL(string: urlStr)
            guard let url = url else {
                delegate.showMenubarView()
                return
            }
            addToUserDefaults(url: url.absoluteString)
        } else {
            delegate.showMenubarView()
            return
        }
    }
    
    func addToUserDefaults(url: String) {
        let msg = NSAlert()
        let delegate = NSApplication.shared.delegate as! AppDelegate
        
        msg.addButton(withTitle: "I'm Sorry, I'm Stupid!")      // 1st button
        msg.messageText = "Repo already added!"
        msg.informativeText = "Repo is already added, why add again bro?"
        
        var repos = UserDefaults.standard.object(forKey:"repos") as? [String] ?? [String]()
        
        if repos.contains(url) || repos.contains(url + "/") {
            let response: NSApplication.ModalResponse = msg.runModal()
            
            if response == NSApplication.ModalResponse.alertFirstButtonReturn {
                getRepoFromUser(title: "Add Repo", question: "Enter Repo URL Here", defaultValue: "")
                return
            }
        } else {
            repos.append(url)
            
            UserDefaults.standard.set(repos, forKey: "repos")
            self.repos = [Repo]()
            self.fetchEmotes(urls: repos)
            delegate.showMenubarView()
        }
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
            if self.isHomeActive == false {
                self.isHomeActive = true
                if self.isAboutActive == true {
                    self.isAboutActive = false
                }
            }
            
        }
    }
    
    func makeAboutActive() {
        DispatchQueue.main.async {
            if self.isHomeActive == true {
                self.isHomeActive = false
                if self.isAboutActive == false {
                    self.isAboutActive = true
                }
            }
        }
    }
    
    func fetchEmotes(urls: [String]) {
        DispatchQueue.main.async {
            for urlString in urls {
                var rep = urlString
                let removeFromURL: Set<Character> = [".", "/"]
                if rep.prefix(8) == "https://" {
                    rep.removeFirst(8)
                }
                rep.removeAll(where: {removeFromURL.contains($0)})
                
                var repoArray = UserDefaults.standard.object(forKey: rep) as? [String] ?? [String]()
                
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
                        var emote = try JSONDecoder().decode(Emote.self, from: data)
                        emote = Emote(name: emote.name, icon: emote.icon, path: emote.path, author: emote.author, emotes: emote.emotes.unique{$0.name == $1.name})
                        DispatchQueue.main.async {
                            let repo = Repo(active: false, url: urlString, favouriteEmotes: repoArray, emote: emote)
                            self.repos.append(repo)
                            self.reorderRepos()
                            self.isLoading = false
                        }
                        DispatchQueue.main.async {
                            if self.selectedRepo.active == true {
                                for repo in self.repos {
                                    if self.selectedRepo.url == repo.url {
                                    self.selectedRepo.favouriteEmotes = repo.favouriteEmotes
                                        break
                                    }
                                }
                            }
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
    
    func fetchFrequentlyUsedEmotes() {
        let frequentlyUsedEmotesArray = UserDefaults.standard.object(forKey: "frequentlyUsedEmotes") as? [String] ?? [String]();
        
        if frequentlyUsedEmotesArray.isEmpty {
            return
        } else {
            DispatchQueue.main.async {
                self.frequentlyUsedEmotes = frequentlyUsedEmotesArray
            }
        }
    }
    
    func fetchFavouriteEmotes() {
        let favouriteEmotesArray = UserDefaults.standard.object(forKey: "favouriteEmotes") as? [String] ?? [String]()
        
        if favouriteEmotesArray.isEmpty {
            return
        } else {
            DispatchQueue.main.async {
                self.favouriteEmotes = favouriteEmotesArray
            }
        }
    }
    
    func removeFromFavouriteEmotes(repo: String, favouriteEmote: String) {
        var rep = repo
        let removeFromURL: Set<Character> = [".", "/"]
        if rep.prefix(8) == "https://" {
            rep.removeFirst(8)
        }
        rep.removeAll(where: {removeFromURL.contains($0)})
        
        var repoArray = UserDefaults.standard.object(forKey: rep) as? [String] ?? [String]()
        var favsArray = UserDefaults.standard.object(forKey: "favouriteEmotes") as? [String] ?? [String]()
        
        repoArray = repoArray.filter({$0 != favouriteEmote})
        favsArray = favsArray.filter({$0 != favouriteEmote})
        
        UserDefaults.standard.set(repoArray, forKey: rep)
        UserDefaults.standard.set(favsArray, forKey: "favouriteEmotes")
        
        DispatchQueue.main.async {
            self.repos = [Repo]()
            self.favouriteEmotes = [String]()
            self.fetchRepos()
            self.fetchFavouriteEmotes()
        }
    }
    
    func addToFavouriteEmotes(repo: String, favouriteEmote: String) {
        var rep = repo
        let removeFromURL: Set<Character> = [".", "/"]
        if rep.prefix(8) == "https://" {
            rep.removeFirst(8)
        }
        rep.removeAll(where: {removeFromURL.contains($0)})
        
        var repoArray = UserDefaults.standard.object(forKey: rep) as? [String] ?? [String]()
        var favsArray = UserDefaults.standard.object(forKey: "favouriteEmotes") as? [String] ?? [String]()
        
        if repoArray.isEmpty {
            repoArray.append(favouriteEmote)
        } else {
            if repoArray.contains(favouriteEmote) {
                for(index, favEmote) in repoArray.enumerated() {
                    if favEmote == favouriteEmote {
                        repoArray.remove(at: index)
                        break
                    }
                }
            }
            
            repoArray.insert(favouriteEmote, at: 0)
        }
        
        if favsArray.isEmpty {
            favsArray.append(favouriteEmote)
        } else {
            if favsArray.contains(favouriteEmote) {
                for(index, favEmote) in favsArray.enumerated() {
                    if favEmote == favouriteEmote {
                        favsArray.remove(at: index)
                        break
                    }
                }
            }
            
            favsArray.insert(favouriteEmote, at: 0)
        }
        
        UserDefaults.standard.set(repoArray, forKey: rep)
        UserDefaults.standard.set(favsArray, forKey: "favouriteEmotes")
        DispatchQueue.main.async {
            self.repos = [Repo]()
            self.favouriteEmotes = [String]()
            self.fetchRepos()
            self.fetchFavouriteEmotes()
        }
    }
    
    func addToFrequentlyUsedEmotes(frequentEmote: String) {
        var frequentlyUsedEmotesArray = UserDefaults.standard.object(forKey: "frequentlyUsedEmotes") as? [String] ?? [String]()
        
        if frequentlyUsedEmotesArray.isEmpty {
            frequentlyUsedEmotesArray.append(frequentEmote)
        } else {
            if frequentlyUsedEmotesArray.contains(frequentEmote) {
                for (index, frequentlyUsedEmote) in frequentlyUsedEmotesArray.enumerated() {
                    if frequentlyUsedEmote == frequentEmote {
                        frequentlyUsedEmotesArray.remove(at: index)
                        break
                    }
                }
            }
            
            if frequentlyUsedEmotesArray.count > 24 {
                frequentlyUsedEmotesArray.removeLast()
            }
            
            frequentlyUsedEmotesArray.insert(frequentEmote, at: 0)
        }
        
        UserDefaults.standard.set(frequentlyUsedEmotesArray, forKey: "frequentlyUsedEmotes")
        DispatchQueue.main.async {
            self.frequentlyUsedEmotes = [String]()
            self.fetchFrequentlyUsedEmotes()
        }
    }
    
    func reorderRepos() {
        self.repos.sort { r1, r2 in
            return r1.emote.name.lowercased() < r2.emote.name.lowercased()
        }
    }
}
