//
//  NewsPresenter.swift
//  NewsApp
//
//  Created by Pavel Bondar on 07.06.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import Foundation

protocol NewsViewProtocol: class {
    func succes()
    func failure(error: Error)
}

protocol NewsViewPresenterProtocol: class {
    init(view: NewsViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, safariService: SafariServiceProtocol, activityService: ActivityViewServiceProtocol)
    func getNews(index: Int)
    var newsFeed: NewsFeed? { get set }
    func tapOnTheArticle(article: Article?)
    func fetchNextNewsList()
    func goToWeb(url: URL?)
    func share(url: URL?)
}

class NewsPresenter: NewsViewPresenterProtocol {
    weak var view: NewsViewProtocol?
    var router: RouterProtocol?
    let networkService: NetworkServiceProtocol!
    var newsFeed: NewsFeed?
    let safariService: SafariServiceProtocol?
    let activityService: ActivityViewServiceProtocol?
    var nextIndex = 0
    
    required init(view: NewsViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, safariService: SafariServiceProtocol, activityService: ActivityViewServiceProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        self.safariService = safariService
        self.activityService = activityService
        getNews(index: 0)
    }
    
    func goToWeb(url: URL?) {
        safariService?.showNewsInBrowser(url: url)
    }
    
    func share(url: URL?) {
        activityService?.shareNews(url: url)
    }
    
    func tapOnTheArticle(article: Article?) {
        router?.showDetail(article: article)
    }
    
    func fetchNextNewsList() {
        getNews(index: nextIndex)
    }
    
    func getNews(index: Int) {
        networkService.dataLoader(to: .country(country: "ua", page: index)) { [weak self] (result: Result<NewsFeed, APIError>) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let newsFeed):
//                    let articles = newsFeed.articles
//                    if index == 0 {
                        self.newsFeed? = newsFeed
//                    } else {
//                        articles.forEach {
//                            self.newsFeed?.articles.append($0)
//                        }
//                    }
                    self.view?.succes()
                    self.nextIndex += 1
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
}
