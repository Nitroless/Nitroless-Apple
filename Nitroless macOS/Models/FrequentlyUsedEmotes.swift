//
//  FrequentlyUsedEmotes.swift
//  Nitroless macOS
//
//  Created by Paras KCD on 2022-10-10.
//

import Foundation

struct FrequentlyUsedEmotes: Codable, Equatable {
    let url: String
    let path: String
    let emote: EmoteElement
}

func ==(lhs: FrequentlyUsedEmotes, rhs: FrequentlyUsedEmotes) -> Bool {
    if lhs.emote == rhs.emote && lhs.url == rhs.url && lhs.path == rhs.path {
        return true
    } else {
        return false
    }
}
