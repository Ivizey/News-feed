//
//  ViewController.swift
//  NewsApp
//
//  Created by Pavel Bondar on 10/27/19.
//  Copyright © 2019 Pavel Bondar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var newsTable: UITableView!
    
    public struct Props {
        var status: String
        var totalResults: Int
        var articles: [Article]
    }
    
    public var props: Props = Props(status: "", totalResults: 0, articles: [Article]()) {
        didSet {
            self.newsTable.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource {
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

