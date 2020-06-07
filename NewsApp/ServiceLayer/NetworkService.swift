//
//  NetworkServices.swift
//  NewsApp
//
//  Created by Pavel Bondar on 16.02.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {
    func getNews(completion: @escaping (Result<NewsFeed?, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    private let API_KEY = "84a521a08cf141aa8bbe269df5f99439"
    
    func getNews(completion: @escaping (Result<NewsFeed?, Error>) -> Void) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "newsapi.org"
        components.path = "/v2/top-headlines"
        components.queryItems = [URLQueryItem(name: "country", value: "ua"),
                                 URLQueryItem(name: "apiKey", value: API_KEY)]
        guard let url = components.url else { return }
        URLSession
            .shared
            .dataTask(with: url) { (data, response, error) in
                guard let response = response as? HTTPURLResponse else { return }
                if let data = data, (200...299).contains(response.statusCode) {
                    do {
                        let news = try JSONDecoder().decode(NewsFeed.self, from: data)
                        completion(.success(news))
                    } catch {
                        print(error.localizedDescription)
                        completion(.failure(error))
                    }
                }
        }.resume()
    }
}
