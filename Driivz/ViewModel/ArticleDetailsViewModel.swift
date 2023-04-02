//
//  ArticleDetailsViewModel.swift
//  Driivz
//
//  Created by Or Chen on 02/04/2023.
//

import Foundation
import UIKit

class ArticleDetailsViewModel {
    let article: Article
    init(article: Article) {
        self.article = article
    }
    
    //In case the design team would like to add transparent background and corner radius to the labels
    func setLabelAppearance(label: UILabel) {
        label.backgroundColor = .gray.withAlphaComponent(0.4)
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
    }
}
