//
//  Constants.swift
//  Nitroless
//
//  Created by Lakhan Lothiyi on 29/09/2022.
//

import Foundation

struct FileLocations {
    static let repoList = URL.documentsDirectory.appending(path: "repos").appendingPathExtension("nitroless")
}

var DefaultReposUrl = URL(string: "https://nitroless.github.io/default.json")!

