//
//  StorageManager.swift
//  Nitroless iOS
//
//  Created by Lakhan Lothiyi on 10/11/2022.
//

import Foundation

class StorageManager: ObservableObject {
    
    static let shared = StorageManager()
    
    var fileLocation: URL = {
        let home = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.llsc12.Nitroless")!
        let docs = home.appending(path: "Documents")
        let storageObjectLocation = docs.appending(path: "storage").appendingPathExtension("object") // add storage.object file
        print(storageObjectLocation)
        return storageObjectLocation
    }()
    
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    var s: StorageObject {
        didSet {
            if self.pauseSaves == false {
                self.objectWillChange.send()
                StorageManager.saveLoadedObjectToLocalStorage(self)
            }
        }
    }
    
    var timerRefresher: Timer? = nil
    var pauseSaves = false
    
    init() {
        
        // create file if it doesnt exist
        if !FileManager.default.fileExists(atPath: fileLocation.path) {
            let starterObj = StorageObject(repos: [], frequentEmotes: [], favouriteEmotes: [], favouriteEmotesPerRepo: [:])
            let json = try? encoder.encode(starterObj)
            try? json?.write(to: fileLocation, options: .atomic)
            
            // else if it does exist, make sure it successfully gets loaded and decodes, else write a blank template.
        } else if let data = try? Data(contentsOf: fileLocation),
                  let _ = try? decoder.decode(StorageObject.self, from: data) {} else {
                      let starterObj = StorageObject(repos: [], frequentEmotes: [], favouriteEmotes: [], favouriteEmotesPerRepo: [:])
                      let json = try? encoder.encode(starterObj)
                      try? json?.write(to: fileLocation, options: .atomic)
                  }
        
        self.s = StorageManager.getObjectFromLocalStorage(decoder, fileLocation, encoder: encoder)
        
        self.timerRefresher = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.pauseSaves = true
            StorageManager.reloadObjectFromLocalStorage(self)
            self.pauseSaves = false
        })
        
        self.objectWillChange.send()
    }
    
    deinit {
        self.timerRefresher?.invalidate()
    }
    
    static private func reloadObjectFromLocalStorage(_ self: StorageManager) {
        self.s = StorageManager.getObjectFromLocalStorage(self.decoder, self.fileLocation, encoder: self.encoder)
    }
    
    static private func saveLoadedObjectToLocalStorage(_ self: StorageManager) {
        print("saving object")
        do {
                let json = try self.encoder.encode(self.s)
                try json.write(to: self.fileLocation, options: .atomic)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    static private func getObjectFromLocalStorage(_ decoder: JSONDecoder, _ fileLocation: URL, encoder: JSONEncoder) -> StorageObject {
        print("loading object")
        do {
            var file: Data
            if FileManager.default.fileExists(atPath: fileLocation.path) {
                file = try Data(contentsOf: fileLocation)
            } else {
                let starterObj = StorageObject(repos: [], frequentEmotes: [], favouriteEmotes: [], favouriteEmotesPerRepo: [:])
                let json = try encoder.encode(starterObj)
                file = json
            }
            
            let object = try decoder.decode(StorageObject.self, from: file)
            
            return object
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

struct StorageObject: Codable {
    var repos, frequentEmotes, favouriteEmotes: [URL]
    var favouriteEmotesPerRepo: [String: [URL]]
}
