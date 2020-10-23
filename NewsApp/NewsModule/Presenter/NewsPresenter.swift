//
//  NewsPresenter.swift
//  NewsApp
//
//  Created by Pavel Bondar on 07.06.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import Foundation
// MARK: - typealias
typealias NewsFetchHandler = Result<NewsFeed, APIError>
// MARK: - NewsViewProtocol
protocol NewsViewProtocol: class {
    func succes()
    func failure(error: Error)
}
// MARK: - NewsViewPresenterProtocol
protocol NewsViewPresenterProtocol: class {
    init(view: NewsViewProtocol,
         networkService: NetworkServiceProtocol,
         router: RouterProtocol)
    var newsFeed: NewsFeed? { get }
    var country: String! { get }
    var title: String! { get }
    func searchNewsFeed(search: String)
    func tapOnTheArticle(article: Article?)
    func updateNewsFeed()
    func goToSettings()
    func fetchNextNewsFeed()
}
// MARK: - NewsViewPresenterProtocol
class NewsPresenter: NewsViewPresenterProtocol {
    weak var view: NewsViewProtocol?
    var router: RouterProtocol?
    var country: String!
    var title: String!
    var newsFeed: NewsFeed?
    var nextIndex: Int!
    let networkService: NetworkServiceProtocol!
    
    required init(view: NewsViewProtocol,
                  networkService: NetworkServiceProtocol,
                  router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        updateNewsFeed()
    }
    // MARK: - update news feed with default values
    func updateNewsFeed() {
        self.country = UserDefaults.standard.string(forKey: "Country") ?? "ua 🇺🇦"
        self.title = UserDefaults.standard.string(forKey: "Category") ?? "general"
        newsFeed = nil
        nextIndex = 10
        fetchNewsFeed(index: nextIndex)
    }
    // MARK: - download a following news list (+ 10)
    func fetchNextNewsFeed() {
        fetchNewsFeed(index: nextIndex)
    }
    // MARK: - download a list news by specified parameters
    func fetchNewsFeed(index: Int) {
        networkService.dataLoader(to: .country(country: String(country.prefix(2)), category: title, page: index)) { [weak self] (result: NewsFetchHandler) in
            guard let self = self else { return }
            self.parseFetchData(result: result)
        }
    }
    // MARK: - search for news by keyword
    func searchNewsFeed(search: String) {
        self.title = "Search"
        self.country = ""
        networkService.dataLoader(to: .search(q: search)) { [weak self] (result: NewsFetchHandler) in
            guard let self = self else { return }
            self.parseFetchData(result: result)
        }
    }
    // MARK: - go to the article in the Safari browser
    func tapOnTheArticle(article: Article?) {
        router?.showDetail(article: article)
    }
    // MARK: - go to the application settings
    func goToSettings() {
        router?.showSettings()
    }
    // MARK: - parse fetch data
    private func parseFetchData(result: NewsFetchHandler) {
        DispatchQueue.main.async {
            switch result {
            case .success(let newsFeed):
                self.newsFeed = newsFeed
                self.nextIndex += 10
                self.view?.succes()
            case .failure(let error):
                self.view?.failure(error: error)
            }
        }
    }
}
