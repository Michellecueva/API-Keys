//
//  Songs.swift
//  APIKeys
//
//  Created by Michelle Cueva on 9/9/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import Foundation

struct SongsWrapper: Codable {
    let message: Message
}

struct Message: Codable {
    let body : Body
}

struct Body: Codable {
    let track_list: [TrackList]
}

struct TrackList: Codable {
    let track: Track
}

struct Track: Codable {
    let track_id: Int
    let track_name: String
    let artist_name: String
    var title: String {
        return self.track_name.replacingOccurrences(of: " ", with: "%20")
    }
}
