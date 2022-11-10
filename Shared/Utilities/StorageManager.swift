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
        URL.documentsDirectory.appending(path: "storage").appendingPathExtension("object")
    }()
    
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    var s: StorageObject {
        didSet {
            self.objectWillChange.send()
            StorageManager.saveLoadedObjectToLocalStorage(self)
        }
    }
    
    init() {
        self.s = StorageManager.getObjectFromLocalStorage(decoder, fileLocation, encoder: encoder)
        self.objectWillChange.send()
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
