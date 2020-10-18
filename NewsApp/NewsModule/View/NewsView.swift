//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Pavel Bondar on 10/27/19.
//  Copyright © 2019 Pavel Bondar. All rights reserved.
//

import UIKit

class NewsView: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var presenter: NewsViewPresenterProtocol!
    let search = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: - register cell
        let newsCell = UINib(nibName: "NewsCell", bundle: nil)
        tableView.register(newsCell, forCellReuseIdentifier: "NewsCell")
        
        search.searchBar.delegate = self
        search.searchBar.showsBookmarkButton = true
        search.searchBar.setImage(UIImage(systemName: "magnifyingglass"), for: .bookmark, state: .normal)
        search.searchBar.searchTextField.clearButtonMode = .always
        search.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = search
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateList),
                                               name: NSNotification.Name("tapApplyAction"), object: nil)
        
        
    }
    
    @objc private func updateList() {
        presenter.updateNewsFeed()
    }
}

extension NewsView: UISearchBarDelegate {
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        guard let text = search.searchBar.text else { return }
        presenter.searchNews(search: text)
    }
}
