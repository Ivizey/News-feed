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
    let search = UISearchController.searchBarSetup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: - register cell
        let newsCell = UINib(nibName: "NewsCell", bundle: nil)
        tableView.register(newsCell, forCellReuseIdentifier: "NewsCell")
        // MARK: - create right bar button
        let menu = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .plain, target: self, action: #selector(goToSettings))
        navigationItem.rightBarButtonItem = menu
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        // MARK: - Setup search controller
        search.searchBar.delegate = self
        navigationItem.searchController = search
        // MARK: - Include notification center
        NotificationCenter.default.addObserver(self, selector: #selector(updateList), name: .applyAction, object: nil)
    }
    
    @objc private func updateList() {
        presenter.updateNewsFeed()
    }
}
