//
//  NewsFeed.swift
//  NewsApp
//
//  Created by Pavel Bondar on 10/27/19.
//  Copyright © 2019 Pavel Bondar. All rights reserved.
//

import Foundation

struct NewsFeed: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}
