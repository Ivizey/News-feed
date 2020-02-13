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
    private let API_KEY = "YOUR_KEY"
    
    public struct Props {
        var status: String
        var totalResults: Int
        var articles: [Article]
    }
    
    public var props: Props = Props(status: "", totalResults: 0, articles: [Article]()) {
        didSet {
            DispatchQueue.main.async {
                self.newsTable.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.fetchNewsFeed { (news, error) in
                self.props.status = (news?.status) ?? ""
                self.props.totalResults = (news?.totalResults) ?? 0
                self.props.articles = news?.articles ?? [Article]()
            }
        }
    }
    
    private func getImage(url: URL) -> UIImage {
        if let data = try? Data(contentsOf: url)
        {
            return UIImage(data: data)!
        } else {
            return UIImage()
        }
    }
    
    private func fetchNewsFeed(completionHandler: @escaping (NewsFeed?, Error?) -> ()) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "newsapi.org"
        components.path = "/v2/top-headlines"
        components.queryItems = [//URLQueryItem(name: "country", value: "us"),
//                                 URLQueryItem(name: "category", value: "technology"),
//                                 URLQueryItem(name: "qInTitle", value: "\"android\""),
//                                 URLQueryItem(name: "domains", value: "techcrunch.com"),
//                                 URLQueryItem(name: "to", value: "2020-02-13"),
//                                 URLQueryItem(name: "sources", value: "techcrunch"),
//                                 URLQueryItem(name: "domains", value: "wsj.com"),
//                                 URLQueryItem(name: "language", value: "ru"),
//                                 URLQueryItem(name: "q", value: "sport"),
//                                 URLQueryItem(name: "from", value: "2020-01-12"),
//                                 URLQueryItem(name: "sortBy", value: "publishedAt"),
//                                 URLQueryItem(name: "pageSize", value: "30"),
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

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.props.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        cell.setImage(image: getImage(url: props.articles[indexPath.row].urlToImage!))
        cell.setTitle(title: props.articles[indexPath.row].title!)
        cell.setDescription(description: props.articles[indexPath.row].description!)
        return cell
    }
}

