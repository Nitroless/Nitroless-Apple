//
//  Emote.swift
//  Nitroless
//
//  Created by Paras KCD on 2022-10-08.
//

import Foundation

struct Repo: Codable {
    var active: Bool
    let url: String
    let emote: Emote
}

struct Emote: Codable {
    let name, icon, path: String
    let emotes: [EmoteElement]
}

struct EmoteElement: Codable, Equatable {
    let name: String
    let type: TypeEnum
}

func ==(lhs: EmoteElement, rhs: EmoteElement) -> Bool {
    if lhs.name == rhs.name && lhs.type == rhs.type {
        return true
    } else {
        return false
    }
}

enum TypeEnum: String, Codable {
    case gif = "gif"
    case png = "png"
    case jpg = "jpg"
}
