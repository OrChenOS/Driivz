//
//  ArticleViewModel.swift
//  Driivz
//
//  Created by Or Chen on 01/04/2023.
//

import Foundation
import UIKit
import XMLCoder

protocol ArticleViewModelDelegate: AnyObject {
    func didFinishFetchingArticles()
}

class ArticleViewModel {
    
    private var articles: [Article] = []
    private let url = URL(string: "https://www.nasa.gov/rss/dyn/lg_image_of_the_day.rss")!
    private var title: String?
    weak var delegate: ArticleViewModelDelegate?
    
    func fetchArticles() {

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            let decoder = XMLDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let rssFeed = try decoder.decode(RSSFeed.self, from: data)
                self.title = rssFeed.channel.title
                for item in rssFeed.channel.item {
                    let article = Article(title: item.title, description: item.description, imageUrl: item.enclosure.url)
                    self.articles.append(article)
                }
                self.delegate?.didFinishFetchingArticles()
            } catch {
                print("Error decoding RSS feed: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func numberOfRows() -> Int {
        return articles.count
    }
    
    func articleAtIndex(_ index: Int) -> Article {
        return articles[index]
    }
    
    func select(article: Article, viewController: UIViewController) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let articleDetailsViewController = storyBoard.instantiateViewController(withIdentifier: "ArticleDetailsViewController") as! ArticleDetailsViewController
        articleDetailsViewController.viewModel = ArticleDetailsViewModel(article: article)
        viewController.present(articleDetailsViewController, animated: true, completion: nil)
    }
    
    func getTitle() -> String {
        return title ?? "Fallback Title"
    }
}

