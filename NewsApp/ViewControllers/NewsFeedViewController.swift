//
//  NewsFeedViewController.swift
//  NewsApp
//
//  Created by Pavel Bondar on 10/27/19.
//  Copyright © 2019 Pavel Bondar. All rights reserved.
//

import UIKit

class NewsFeedViewController: UIViewController {
    @IBOutlet private weak var newsTable: UITableView!
    private let networkServices = NetworkService()
    
    public struct Props {
        var status: String?
        var totalResults: Int?
        var articles: [Article]
    }
    
    public var props: Props = Props(status: "", totalResults: 0,
                                    articles: [Article]()) {
        didSet {
            DispatchQueue.main.async {
                self.newsTable.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.title = "News Feed"
        getNews()
        networkServices.fetchDataPUT()
    }
    
    private func getNews() {
        networkServices.fetchNewsFeed { [weak self] (news, error) in
            DispatchQueue.main.async {
                self?.props.status = news?.status
                self?.props.totalResults = news?.totalResults
                self?.props.articles = news?.articles ?? [Article]()
            }
        }
    }
}

extension NewsFeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.props.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        cell.setTitle(title: props.articles[indexPath.row].title)
        cell.setDescription(description: props.articles[indexPath.row].description)
        return cell
    }
}

