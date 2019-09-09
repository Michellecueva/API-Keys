//
//  ViewController.swift
//  APIKeys
//
//  Created by Michelle Cueva on 9/9/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var songsSearchBar: UISearchBar!
    
    @IBOutlet weak var songTableView: UITableView!
    
    var songs = [Track]() {
        didSet {
            songTableView.reloadData()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        songTableView.dataSource = self
        songsSearchBar.delegate = self
    }
    
    private func loadData(url: String) {
        
        SongAPIHelper.shared.getSongs(url:url) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let songsFromJSON):
                    self.songs = songsFromJSON
                }
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let song = songs[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        cell.textLabel?.text = "Artist: \(song.artist_name)"
        cell.detailTextLabel?.text = "Title: \(song.track_name)"
        return cell
    }
}
extension ViewController: UISearchBarDelegate{

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        loadData(url: searchBar.text!)
    }
}
