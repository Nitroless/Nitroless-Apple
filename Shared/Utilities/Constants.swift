//
//  Constants.swift
//  Nitroless
//
//  Created by Lakhan Lothiyi on 29/09/2022.
//

import Foundation

struct FileLocations {
    static let repoList = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.llsc12.Nitroless")!.appendingPathComponent("Documents").appending(path: "repos").appendingPathExtension("nitroless")
    static let frequentEmotes = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.llsc12.Nitroless")!.appendingPathComponent("Documents").appending(path: "frequentEmotes").appendingPathExtension("nitroless")
}

var DefaultReposUrl = URL(string: "https://nitroless.github.io/default.json")!

