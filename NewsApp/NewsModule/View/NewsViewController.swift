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
    private var timer: Timer?
    var presenter: NewsViewPresenterProtocol!
}

// MARK: - UITableViewDataSource
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.frame.origin.x = -cell.frame.width
        UIView.animate(withDuration: 0.7, delay: 0.2, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
            cell.frame.origin.x = 0
        }, completion: nil)
    }
}

// MARK: - UITableViewDelegate
extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = presenter.newsFeed?.articles[indexPath.row]
        presenter.tapOnTheArticle(article: article)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let article = self.presenter.newsFeed?.articles[indexPath.row]
        let openBrowser = UIContextualAction(style: .normal, title: "Open in browser") {  (contextualAction, view, boolValue) in
            self.presenter.goToWeb(url: article?.url)
        }
        let share = UIContextualAction(style: .normal, title: "Share") {  (contextualAction, view, boolValue) in
            self.presenter.share(url: article?.url)
        }
        share.backgroundColor = .systemBlue
        return UISwipeActionsConfiguration(actions: [openBrowser, share])
    }
}

// MARK: - NewsViewProtocol
extension NewsViewController: NewsViewProtocol {
    func succes() {
        title = "News feed: \(presenter.newsFeed?.totalResults ?? 0)"
        tableView.reloadData()
    }
    
    func failure(error: Error) {
        print("Error: \(error.localizedDescription)")
    }
}
