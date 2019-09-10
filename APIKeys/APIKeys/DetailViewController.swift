//
//  DetailViewController.swift
//  APIKeys
//
//  Created by Michelle Cueva on 9/9/19.
//  Copyright © 2019 Michelle Cueva. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var lyricsField: UITextView!
    
    var songs: Track!
    
    var lyrics: Lyrics! {
        didSet {
            lyricsField.text = lyrics.lyrics_body
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = songs.track_name
        lyricsField.isEditable = false

    }
    


}
