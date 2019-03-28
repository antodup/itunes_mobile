//
//  ViewController.swift
//  Itunes
//
//  Created by Anthony  Dupré on 15/03/2019.
//  Copyright © 2019 Anthony  Dupré. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITabBarDelegate, UITableViewDataSource {
    
    var albums:[Album] = []
    var nameArtist = String()
    var results = [JSON]()
    @IBOutlet weak var Table: UITableView!
    @IBOutlet weak var searchText: UITextField!
    @IBAction func go(_ sender: Any) {
        self.nameArtist = searchText.text!
        APIRequest(textSearch: self.nameArtist)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let album = albums[indexPath.item]
        cell.ablum.text = album.title
        cell.artiste.text = album.artiste
        cell.musique.text = album.musique
        cell.pictures.image = UIImage(named: album.pictures)
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //initData()
     }
    
    func initData() {
        albums.removeAll(keepingCapacity: true)
        
        let album = Album()
        album.title = "Cure"
        album.artiste =  "Eddy de Pretto"
        album.pictures = "eddy"
        album.musique = "Kid"
        albums.append(album);
    }
    
    func APIRequest(textSearch: String) {
        AF.request("https://itunes.apple.com/search?term=\(String(describing: textSearch))")
            .responseJSON { response in
                let parsedJson = JSON(response.result.value!)
                self.results = parsedJson["results"].arrayValue
                
                for result in self.results {
                   //self.albums.removeAll(keepingCapacity: true)
                    let album = Album()
                    album.title = "\(result["primaryGenreName"].stringValue)"
                    album.artiste =  "\(result["artistName"].stringValue)"
                    album.pictures = "\(result["artworkUrl60"].stringValue)"
                    album.musique = "\(result["trackName"].stringValue)"
                    self.albums.append(album);
                    self.Table.reloadData()
                }
            }
    }
}
