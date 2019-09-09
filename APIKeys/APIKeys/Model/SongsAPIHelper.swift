//
//  SongsAPIHelper.swift
//  APIKeys
//
//  Created by Michelle Cueva on 9/9/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import Foundation

struct  SongAPIHelper {
    private init() {}
    
    static var shared = SongAPIHelper()
    
    func getUrl(str:String) -> String {
        return "https://api.musixmatch.com/ws/1.1/track.search?q_artist=\(str)&page_size=5&apikey=261deb4710e0b9d1cd52b236a620d02d"
    }
    
    
    mutating func getSongs(url: String, completionHandler: @ escaping (Result<[Track], AppError>) -> ()) {
        
        
        NetworkManager.shared.fetchData(urlString: getUrl(str: url)) {
            (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let showInfo = try JSONDecoder().decode(SongsWrapper.self, from: data)
                    let trackList = showInfo.message.body.track_list
                    let track = trackList.map{$0.track}
                    completionHandler(.success(track))
                    
                } catch {
                    completionHandler(.failure(.noDataError))
                }
            }
        }
    }
}
