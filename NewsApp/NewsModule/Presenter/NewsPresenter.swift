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
    init(view: NewsViewProtocol,
         networkService: NetworkServiceProtocol,
         router: RouterProtocol,
         userDefaults: UserDefaults,
         safariService: SafariServiceProtocol,
         activityService: ActivityViewServiceProtocol)
    func getNews(country: String, category: String, index: Int)
    func searchNews(search: String)
    var newsFeed: NewsFeed? { get set }
    var title: String? { get }
    var actualCountry: String? { get }
    func tapOnTheArticle(article: Article?)
    func updateNewsFeed()
    func goToSettings()
    func fetchNextNewsList()
    func goToWeb(url: URL?)
    func share(url: URL?)
}

class NewsPresenter: NewsViewPresenterProtocol {
    weak var view: NewsViewProtocol?
    var router: RouterProtocol?
    var userDefaults: UserDefaults!
    var title: String?
    var actualCountry: String?
    var nextIndex = 0
    var newsFeed: NewsFeed?
    let networkService: NetworkServiceProtocol!
    let safariService: SafariServiceProtocol?
    let activityService: ActivityViewServiceProtocol?
    
    required init(view: NewsViewProtocol,
                  networkService: NetworkServiceProtocol,
                  router: RouterProtocol,
                  userDefaults: UserDefaults,
                  safariService: SafariServiceProtocol,
                  activityService: ActivityViewServiceProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        self.userDefaults = userDefaults
        self.safariService = safariService
        self.activityService = activityService
        updateNewsFeed()
    }
    
    func updateNewsFeed() {
        newsFeed = nil
        nextIndex = 10
        let country = userDefaults.string(forKey: "Country") ?? "ua"
        let category = userDefaults.string(forKey: "Category") ?? "general"
        self.title = category
        self.actualCountry = country
        getNews(country: String(country.prefix(2)), category: category, index: 10)
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
    
    func goToSettings() {
        router?.showSettings()
    }
    
    func fetchNextNewsList() {
        let country = userDefaults.string(forKey: "Country")?.prefix(2) ?? "ua"
        let category = userDefaults.string(forKey: "Category") ?? "general"
        getNews(country: String(country), category: category, index: nextIndex)
    }
    
    func getNews(country: String, category: String, index: Int) {
        networkService.dataLoader(to: .country(country: country, category: category, page: index)) { [weak self] (result: Result<NewsFeed, APIError>) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let newsFeed):
                    self.newsFeed = newsFeed
                    self.view?.succes()
                    self.nextIndex += 10
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
    
    func searchNews(search: String) {
        networkService.dataLoader(to: .search(q: search)) { [weak self] (result: Result<NewsFeed, APIError>) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let newsFeed):
                    self.newsFeed = nil
                    self.newsFeed = newsFeed
                    self.view?.succes()
                    self.nextIndex += 10
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
}
