//
//  NetworkServices.swift
//  NewsApp
//
//  Created by Pavel Bondar on 16.02.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import Foundation

class NetworkService {
    private let API_KEY = "YOUR_KEY"
    private func fetchNewsFeed(completionHandler: @escaping (NewsFeed?, Error?) -> ()) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "newsapi.org"
        components.path = "/v2/top-headlines"
        components.queryItems = [URLQueryItem(name: "country", value: "us"),
                                 URLQueryItem(name: "apiKey", value: API_KEY)]
        guard let url = components.url else { return }
        URLSession
            .shared
            .dataTask(with: url) { (data, response, error) in
                guard let response = response as? HTTPURLResponse else { return }
                if let data = data, (200...299).contains(response.statusCode) {
                    do {
                        let news = try JSONDecoder().decode(NewsFeed.self, from: data)
                        completionHandler(news, nil)
                    } catch {
                        print(error.localizedDescription)
                        completionHandler(nil, error)
                    }
                }
        }.resume()
    }
}
