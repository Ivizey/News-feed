//
//  UISearchController + Extensions.swift
//  NewsApp
//
//  Created by Pavel Bondar on 19.10.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit.UISearchController

extension UISearchController {
    class func searchBarSetup() -> UISearchController {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.showsBookmarkButton = true
        searchController.searchBar.setImage(UIImage(systemName: "magnifyingglass"), for: .bookmark, state: .normal)
        searchController.searchBar.searchTextField.clearButtonMode = .always
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }
}
