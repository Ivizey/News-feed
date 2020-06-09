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
    }
}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.newsFeed?.articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let article = presenter.newsFeed?.articles[indexPath.row]
        cell.textLabel?.text = article?.title
        cell.textLabel?.textColor = .systemBlue
        cell.detailTextLabel?.text = article?.description
        return cell
    }
}

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = presenter.newsFeed?.articles[indexPath.row]
        presenter.tapOnTheArticle(article: article)
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
