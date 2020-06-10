//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Pavel Bondar on 10/27/19.
//  Copyright © 2019 Pavel Bondar. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    var presenter: NewsViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.newsFeed?.articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let article = presenter.newsFeed?.articles[indexPath.row]
        let source = article?.source.name?.prefix(1).lowercased()
        cell.textLabel?.text = article?.title
        cell.textLabel?.textColor = .systemBlue
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = article?.description
        cell.detailTextLabel?.textColor = .darkGray
        if let source = source {
            cell.imageView?.image = UIImage(systemName: "\(source).square")
            cell.imageView?.tintColor = .black
        }
        return cell
    }
}

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = presenter.newsFeed?.articles[indexPath.row]
        presenter.tapOnTheArticle(article: article)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let openBrowser = UIContextualAction(style: .normal, title: "Open in browser") {  (contextualAction, view, boolValue) in
            print("Delete")
        }
        let share = UIContextualAction(style: .normal, title: "Share") {  (contextualAction, view, boolValue) in
            print("Share")
        }
        share.backgroundColor = .systemBlue
        return UISwipeActionsConfiguration(actions: [openBrowser, share])
    }
}

extension NewsViewController: NewsViewProtocol {
    func succes() {
        self.title = "Результатів: \(presenter.newsFeed?.totalResults ?? 0)"
        tableView.reloadData()
    }
    
    func failure(error: Error) {
        print("Error: \(error.localizedDescription)")
    }
}
