//
//  PageFavViewController.swift
//  Itunes
//
//  Created by Anthony  Dupré on 08/05/2019.
//  Copyright © 2019 Anthony  Dupré. All rights reserved.
//

import UIKit

class PageFavViewController: UIViewController, UITabBarDelegate, UITableViewDataSource, UITextFieldDelegate, UITableViewDelegate {
    
    var favoritesShow:[Album] = []
    var index = 0
    
    @IBOutlet weak var tableViewFav: UITableView!
    
    @IBAction func favBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewFav.reloadData()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellFav", for: indexPath) as! TableViewCell
        let album = favoritesShow[indexPath.item]
        cell.ablum.text = album.title
        cell.artiste.text = album.artiste
        cell.musique.text = album.musique
        cell.deleteFav.tag = indexPath.row
        cell.deleteFav.addTarget(self, action: #selector(deleteFavorites(sender:)) , for: .touchUpInside)
        
        //IMAGE
        let urlImg = URL(string: album.pictures)
        let dataImg = try? Data(contentsOf: urlImg!)
        cell.pictures.image = UIImage(data : dataImg!)
        return cell
    }
    
    @objc func deleteFavorites(sender:UIButton) {
        favoritesShow.remove(at: sender.tag)
        self.tableViewFav.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.index = indexPath.row
        //        print(self.index)
        performSegue(withIdentifier: "previewFav", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "previewFav" {
            let playerController = segue.destination as! PlayerViewController
            
            playerController.coverImage = self.favoritesShow[self.index].pictures
            playerController.titleMusic = self.favoritesShow[self.index].musique
            playerController.artisteName = self.favoritesShow[self.index].artiste
            playerController.kindMusic = self.favoritesShow[self.index].title
            playerController.urlPreview = self.favoritesShow[self.index].urlPreview
        }
        
    }

}
