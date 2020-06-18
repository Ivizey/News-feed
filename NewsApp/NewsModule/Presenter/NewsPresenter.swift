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
    init(view: NewsViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    func getNews()
    var newsFeed: NewsFeed? { get set }
    func tapOnTheArticle(article: Article?)
    func goToWeb(url: URL?)
    func share(url: URL?)
}

class NewsPresenter: NewsViewPresenterProtocol {

    weak var view: NewsViewProtocol?
    var router: RouterProtocol?
    let networkService: NetworkServiceProtocol!
    var newsFeed: NewsFeed?
    let safariService = SafariService()
    let activityService = ActivityViewService()
    
    required init(view: NewsViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        getNews()
    }
    
    func goToWeb(url: URL?) {
        safariService.showNewsInBrowser(url: url)
    }
    
    func share(url: URL?) {
        activityService.shareNews(url: url)
    }
    
    func tapOnTheArticle(article: Article?) {
        router?.showDetail(article: article)
    }
    
    func getNews() {
        networkService.dataLoader(to: .country(country: "ua", page: 1)) { [weak self] (result: Result<NewsFeed, APIError>) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let newsFeed):
                    self.newsFeed = newsFeed
                    self.view?.succes()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
}
