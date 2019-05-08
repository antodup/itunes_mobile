import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var pictures: UIImageView!
    @IBOutlet weak var artiste: UILabel!
    @IBOutlet weak var ablum: UILabel!
    @IBOutlet weak var musique: UILabel!
    @IBOutlet weak var favorites: UIButton!
    @IBOutlet weak var deleteFav: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
