//
//  NewsView + Extensions.swift
//  NewsApp
//
//  Created by Pavel Bondar on 06.10.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit

// MARK: - UISearchBarDelegate
extension NewsView: UISearchBarDelegate {
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        guard let text = search.searchBar.text else { return }
        if text.count > 0 {
            presenter.searchNewsFeed(search: text)
        }
    }
}

// MARK: - UITableViewDataSource
extension NewsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.newsFeed?.articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = presenter.newsFeed?.articles[indexPath.row]
        if let article = article {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
            cell.setupCell(article: article)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == tableView.numberOfSections - 1 &&
            indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.presenter.fetchNextNewsFeed()
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
        title = presenter.title?.uppercased()
        let header = HeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 50))
        header.setStatus(status: "Articles: \(presenter.newsFeed?.totalResults ?? 0)",
                         country: presenter.country?.uppercased() ?? "")
        tableView.tableHeaderView = header
        tableView.reloadData()
    }
    
    func failure(error: Error) {
        print("Error: \(error.localizedDescription)")
    }
    
    @objc func goToSettings() {
        presenter.goToSettings()
    }
}
