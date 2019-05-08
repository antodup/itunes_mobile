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
import FirebaseAuth
import Firebase


class ViewController: UIViewController, UITabBarDelegate, UITableViewDataSource, UITextFieldDelegate, UITableViewDelegate {
    var albums:[Album] = []
    var nameArtist = String()
    var results = [JSON]()
    var favorites:[Album] = []
    var index = 0
    


    @IBOutlet weak var Table: UITableView!
    @IBOutlet weak var searchText: UITextField!
    
    @IBAction func actionEdit(_ sender: Any) {
        if searchText.text!.count < 2 {
            searchText.layer.borderColor = UIColor.red.cgColor
            searchText.layer.borderWidth = 1.0
        } else {
            searchText.layer.borderColor = UIColor.lightGray.cgColor
            searchText.layer.borderWidth = 1.0
        }
    }
    
    @IBAction func lougout(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
            self.present(loginVC, animated:true, completion:nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.nameArtist = searchText.text!
        if self.nameArtist.count < 2 {
            let alert : UIAlertView = UIAlertView(title: "Error", message: "Please write more than 2 characters", delegate: nil, cancelButtonTitle: "Cancel")
            alert.show()
            searchText.layer.borderColor = UIColor.red.cgColor
            searchText.layer.borderWidth = 1.0
        } else {
            albums.removeAll();
            APIRequest(textSearch: self.nameArtist)
            
        }

        return true
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
        
        cell.favorites.tag = indexPath.row
        cell.favorites.addTarget(self, action: #selector(addFavorites(sender:)) , for: .touchUpInside)
        
        //IMAGE
        let urlImg = URL(string: album.pictures)
        let dataImg = try? Data(contentsOf: urlImg!)
        cell.pictures.image = UIImage(data : dataImg!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.index = indexPath.row
        performSegue(withIdentifier: "preview", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "preview" {
            let playerController = segue.destination as! PlayerViewController
            
            playerController.coverImage = self.albums[self.index].pictures
            playerController.titleMusic = self.albums[self.index].musique
            playerController.artisteName = self.albums[self.index].artiste
            playerController.kindMusic = self.albums[self.index].title
            playerController.urlPreview = self.albums[self.index].urlPreview
        }
        else if segue.identifier == "showFav" {
            let pageFavController = segue.destination as! PageFavViewController
            pageFavController.favoritesShow = favorites
        }
      
    }
    
    @objc func addFavorites(sender:UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            var currentIndex = 0

            for favoris in favorites{
                if favoris.idSong == albums[sender.tag].idSong {
                    print("Found \(favoris.musique) for index \(currentIndex)")
                    break
                }
                currentIndex += 1
            }
            favorites.remove(at: currentIndex)
            print(favorites)
        } else {
            sender.isSelected = true
            favorites.append(albums[sender.tag])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchText.returnKeyType = UIReturnKeyType.search
        searchText.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        //initData()
     }

    func APIRequest(textSearch: String) {
        AF.request("https://itunes.apple.com/search?term=\(String(describing: textSearch))")
            .responseJSON { response in
                let parsedJson = JSON(response.result.value)
                self.results = parsedJson["results"].arrayValue
                
                for result in self.results {
                   //self.albums.removeAll(keepingCapacity: true)
                    let album = Album()
                    album.idSong = "\(result["trackId"].stringValue)"
                    album.title = "\(result["primaryGenreName"].stringValue)"
                    album.artiste =  "\(result["artistName"].stringValue)"
                    album.pictures = "\(result["artworkUrl100"].stringValue)"
                    album.musique = "\(result["trackName"].stringValue)"
                    album.urlPreview = "\(result["previewUrl"].stringValue)"
                    self.albums.append(album);
                    self.Table.reloadData()
                }
            }
    }
}
