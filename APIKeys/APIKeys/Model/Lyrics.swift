//
//  Lyrics.swift
//  APIKeys
//
//  Created by Michelle Cueva on 9/9/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import Foundation

struct LyricsWrapper: Codable {
    let message: Message2
}

struct Message2: Codable {
    let body: Body2
}

struct Body2: Codable {
    let lyrics: Lyrics
}

struct  Lyrics: Codable {
    let lyrics_body: String
}
