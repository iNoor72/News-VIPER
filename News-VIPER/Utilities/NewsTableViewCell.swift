//
//  NewsTableViewCell.swift
//  News-VIPER
//
//  Created by Mohamed Ali on 28/04/2024.
//

import UIKit
import SDWebImage

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var favButton: UIButton!
    var favouriteButtonTapped: ( (UITableViewCell) -> Void )?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        favButton.configuration?.image = UIImage(systemName: "bookmark")
    }
    
    func setLabelText(with text: String) {
        newsLabel.text = text
    }
    
    func configureCell(with articleItem: ArticleViewItem) {
        newsLabel.text = articleItem.title
        newsImageView.sd_setImage(with: URL(string: articleItem.ImageURL), placeholderImage: UIImage(named: "placeholder-image.png"))
        favButton.configuration?.image = articleItem.isSaved ?  UIImage(systemName: "bookmark.fill") : UIImage(systemName: "bookmark")
    }
    
    @IBAction func didFavouriteButtonTapped(_ sender: Any) {
        guard let favouriteButtonTapped = favouriteButtonTapped else {
            return
        }
        favouriteButtonTapped(self)
    }
}

