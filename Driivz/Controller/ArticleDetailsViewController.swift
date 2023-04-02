//
//  ArticleDetailsViewController.swift
//  Driivz
//
//  Created by Or Chen on 02/04/2023.
//

import UIKit
import Kingfisher

class ArticleDetailsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    
    var viewModel: ArticleDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        guard let viewModel, let imageUrl = URL(string: viewModel.article.imageUrl) else { return }
        titleLabel.text = viewModel.article.title
        descriptionLabel.text = viewModel.article.description
        articleImageView.kf.setImage(with: imageUrl)
    }

}
