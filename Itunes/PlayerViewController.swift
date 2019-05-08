//
//  PlayerViewController.swift
//  Itunes
//
//  Created by Anthony  Dupré on 08/05/2019.
//  Copyright © 2019 Anthony  Dupré. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {

    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var musique: UILabel!
    @IBOutlet weak var genreSong: UILabel!
    @IBOutlet weak var artiste: UILabel!
    
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    
    var coverImage = ""
    var titleMusic = ""
    var artisteName = ""
    var kindMusic = ""
    var urlPreview = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        musique.text = titleMusic
        genreSong.text = kindMusic
        artiste.text = artisteName
        
        let urlImage = URL(string: coverImage)
        let dataImg = try? Data(contentsOf: urlImage!)
        cover.image = UIImage(data : dataImg!)
        
        let url = URL(string: urlPreview)
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        player?.play()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
