//
//  NewsModuleTest.swift
//  NewsAppTests
//
//  Created by Pavel Bondar on 07.06.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import XCTest
@testable import NewsApp

class MockView: NewsViewProtocol {
    func succes() {
    }
    
    func failure(error: Error) {
    }
}

class MockNetworkService: NetworkServiceProtocol {
    var news: NewsFeed!
    
    init() {}
    
    convenience init(newsFeed: NewsFeed?) {
        self.init()
        self.news = newsFeed
    }
    
    func getNews(completion: @escaping (Result<NewsFeed?, Error>) -> Void) {
        if let news = news {
            completion(.success(news))
        } else {
            let error = NSError(domain: "", code: 0, userInfo: nil)
            completion(.failure(error))
        }
    }
}

class NewsModuleTest: XCTestCase {
    
    var view: MockView!
    var presenter: NewsPresenter!
    var networkService: NetworkServiceProtocol!
    var router: RouterProtocol!
    var news = NewsFeed(status: "", totalResults: 1, articles: [
        Article(source: Source(id: "", name: ""),
                author: "",
                title: nil,
                description: nil,
                url: nil,
                urlToImage: nil,
                publishedAt: nil,
                content: nil)
    ])
    
    override func setUpWithError() throws {
        let nav = UINavigationController()
        let assembly = AsselderModelBuilder()
        router = Router(navigationController: nav, assemblyBuilder: assembly)
    }

    override func tearDownWithError() throws {
        view = nil
        networkService = nil
        presenter = nil
    }
    
    func testGetSuccesNewsFeed() {
        let newsFeed = NewsFeed(status: "ok", totalResults: 1, articles: [
            Article(source: Source(id: "id", name: "Baz"),
                    author: "Foo",
                    title: "title",
                    description: "description",
                    url: nil,
                    urlToImage: nil,
                    publishedAt: nil,
                    content: "content")
        ])
        view = MockView()
        networkService = MockNetworkService(newsFeed: newsFeed)
        presenter = NewsPresenter(view: view, networkService: networkService, router: router)
        
        var catchNews: NewsFeed?
        
        networkService.getNews { result in
            switch result {
            case .success(let newsFeed):
                catchNews = newsFeed
            case .failure(let error):
                print("Error: \(error.localizedDescription  )")
            }
        }
        
        XCTAssertNotEqual(catchNews?.articles.count, 0)
        XCTAssertEqual(catchNews?.articles.count, newsFeed.articles.count)
    }
    
    func testGetFailureNewsFeed() {
        _ = NewsFeed(status: "ok", totalResults: 1, articles: [
            Article(source: Source(id: "id", name: "Baz"),
                    author: "Foo",
                    title: "title",
                    description: "description",
                    url: nil,
                    urlToImage: nil,
                    publishedAt: nil,
                    content: "content")
        ])
        view = MockView()
        networkService = MockNetworkService()
        presenter = NewsPresenter(view: view, networkService: networkService, router: router)
        
        var catchError: Error?
        
        networkService.getNews { result in
            switch result {
            case .success(let newsFeed):
                print("NewsFeed: \(newsFeed!)")
            case .failure(let error):
                catchError = error
            }
        }
        
        XCTAssertNotNil(catchError, "Error is not nil")
    }
}
