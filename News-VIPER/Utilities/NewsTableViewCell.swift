//
//  NewsTableViewCell.swift
//  News-VIPER
//
//  Created by Mohamed Ali on 28/04/2024.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var favButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        favButton.configuration?.image = UIImage(systemName: "bookmark")
    }
    
    func setLabelText(with text: String) {
        newsLabel.text = text
    }
    
}
