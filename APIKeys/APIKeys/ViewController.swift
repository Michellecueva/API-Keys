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
        configureTableview()
        songsSearchBar.delegate = self
    }
    
    private func configureTableview() {
        songTableView.dataSource = self
        songTableView.tableFooterView = UIView()
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
        cell.textLabel?.text = "Title: \(song.track_name)"
        cell.detailTextLabel?.text = "Artist: \(song.artist_name)"
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueIdentifier = segue.identifier else {fatalError("No identifier in segue")}
        
        switch segueIdentifier {
        case "songSegue":
            guard let DetailVC = segue.destination as? DetailViewController else {fatalError("unexpected segueVC")}
            guard let selectedIndexPath = songTableView.indexPathForSelectedRow else{fatalError("no row selected")}
            let song = songs[selectedIndexPath.row]
            DetailVC.songs = song
            
            LyricsAPIHelper.shared.getLyrics(url:song.title) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let lyricsFromJSON):
                        DetailVC.lyrics = lyricsFromJSON
                    }
                }
            }
        
        default:
            fatalError("unexpected segue identifies")
        }
        
    }    
}
extension ViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchString = searchBar.text?.replacingOccurrences(of: " ", with: "%20")
        loadData(url: searchString!)
    }
}
