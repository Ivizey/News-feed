//
//  Settings.swift
//  NewsApp
//
//  Created by Pavel Bondar on 13.10.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import Foundation

class Settings {
    var country: String
    var category: String
    
    init(country: String, category: String) {
        self.country = country
        self.category = category
    }
}
