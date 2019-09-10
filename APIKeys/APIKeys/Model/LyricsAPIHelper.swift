//
//  File.swift
//  APIKeys
//
//  Created by Michelle Cueva on 9/9/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import Foundation
struct  LyricsAPIHelper {
    private init() {}
    
    static var shared = LyricsAPIHelper()
    
    func getUrl(str:String) -> String {
        return "https://api.musixmatch.com/ws/1.1/matcher.lyrics.get?q_track=\(str)&apikey=261deb4710e0b9d1cd52b236a620d02d"
    }
    
    
    mutating func getLyrics(url: String, completionHandler: @ escaping (Result<Lyrics, AppError>) -> ()) {
        
        
        NetworkManager.shared.fetchData(urlString: getUrl(str: url)) {
            (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let lyricsInfo = try JSONDecoder().decode(LyricsWrapper.self, from: data)
                    let lyrics = lyricsInfo.message.body.lyrics
                    completionHandler(.success(lyrics))
                    
                } catch {
                    completionHandler(.failure(.noDataError))
                }
            }
        }
    }
}
