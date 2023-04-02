//
//  NasaNewsFeedViewController.swift
//  Driivz
//
//  Created by Or Chen on 01/04/2023.
//

import UIKit

class NasaNewsFeedViewController: UIViewController, ArticleViewModelDelegate {
    

    @IBOutlet weak var tableView: UITableView!
    private let viewModel = ArticleViewModel()
    private let cellIdentifier = "ArticleTableViewCell"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel.delegate = self
        viewModel.fetchArticles()
    }
    
    func didFinishFetchingArticles() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.setHeaderViewWithTitle(title: self.viewModel.getTitle())
        }
    }
}

extension NasaNewsFeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ArticleTableViewCell
        let article = viewModel.articleAtIndex(indexPath.row)
        cell.configure(with: article)
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = viewModel.articleAtIndex(indexPath.row)
        viewModel.select(article: article, viewController: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func setHeaderViewWithTitle(title: String) {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60))
        let titleLabel = UILabel(frame: CGRect(x: 15, y: 0, width: headerView.frame.width, height: headerView.frame.height))
        titleLabel.text = title
        titleLabel.font = UIFont(name: "Hoefler Text Black", size: 28)
        headerView.addSubview(titleLabel)
        tableView.tableHeaderView = headerView

    }

}
