//
//  Constants.swift
//  Nitroless
//
//  Created by Lakhan Lothiyi on 29/09/2022.
//

import Foundation

struct FileLocations {
    static var repoList: URL = {
        let root = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.llsc12.Nitroless")!
        var str = root.absoluteString + "Documents/repos.nitroless"
        str=String(str.dropFirst(7))
        let final = URL(string: str)!
        return final
    }()
    static var frequentEmotes: URL = {
        let root = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.llsc12.Nitroless")!
        var str = root.absoluteString + "Documents/frequentEmotes.nitroless"
        str=String(str.dropFirst(7))
        let final = URL(string: str)!
        return final
    }()
    static var favouriteEmotes: URL = {
        let root = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.llsc12.Nitroless")!
        var str = root.absoluteString + "Documents/favouriteEmotes.nitroless"
        str=String(str.dropFirst(7))
        let final = URL(string: str)!
        return final
    }()
}

var DefaultReposUrl = URL(string: "https://nitroless.app/default.json")!

//extension URL {
//    func appending(componentThing: String) {
//        let a = componentThing
//        let str = self.absoluteString
//        let urlcomp = self.host
//        
//    }
//}

