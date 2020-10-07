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
    private var timer: Timer?
    var presenter: NewsViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newsCell = UINib(nibName: "NewsCell", bundle: nil)
        tableView.register(newsCell, forCellReuseIdentifier: "NewsCell")
    }
}
