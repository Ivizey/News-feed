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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == tableView.numberOfSections - 1 &&
            indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                self.presenter.fetchNextNewsList()
            }
        }
    }
}

// MARK: - UITableViewDelegate
extension NewsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = presenter.newsFeed?.articles[indexPath.row]
        presenter.tapOnTheArticle(article: article)
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
