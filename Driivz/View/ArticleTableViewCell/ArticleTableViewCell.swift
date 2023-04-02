//
//  ArticleTableViewCell.swift
//  Driivz
//
//  Created by Or Chen on 01/04/2023.
//

import UIKit
import Kingfisher

class ArticleTableViewCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        articleImageView.layer.cornerRadius = articleImageView.frame.height / 2
        articleImageView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with article: Article) {
        titleLabel.text = article.title
        descriptionLabel.text = article.description
        if let imageUrl = URL(string: article.imageUrl) {
            DispatchQueue.global().async {
                KingfisherManager.shared.retrieveImage(with: imageUrl) { result in
                    switch result{
                    case .success(let value):
                        let image = value.image.resizeImage()
                        DispatchQueue.main.async {
                            self.articleImageView.image = image
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
    

}

