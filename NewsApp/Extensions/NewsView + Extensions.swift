//
//  NewsView + Extensions.swift
//  NewsApp
//
//  Created by Pavel Bondar on 06.10.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit

// MARK: - UITableViewDataSource
extension NewsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.newsFeed?.articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = presenter.newsFeed?.articles[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        cell.setupCell(image: article?.urlToImage, title: article?.title)
        return cell
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        cell.frame.origin.x = -cell.frame.width
//        UIView.animate(withDuration: 0.7, delay: 0.2, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
//            cell.frame.origin.x = 0
//        }, completion: nil)
//    }
}

// MARK: - UITableViewDelegate
extension NewsView: UITableViewDelegate {
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
extension NewsView: NewsViewProtocol {
    func succes() {
        title = "News feed: \(presenter.newsFeed?.totalResults ?? 0)"
        tableView.reloadData()
    }
    
    func failure(error: Error) {
        print("Error: \(error.localizedDescription)")
    }
}
