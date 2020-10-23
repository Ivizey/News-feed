//
//  DetailPresenter.swift
//  NewsApp
//
//  Created by Pavel Bondar on 07.06.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import Foundation
// MARK: - DetailViewProtocol
protocol DetailViewProtocol: class {
    func setArticle(article: Article?)
}
// MARK: - DetailViewPresenterProtocol
protocol DetailViewPresenterProtocol: class {
    init(view: DetailViewProtocol,
         networkService: NetworkManager,
         router: RouterProtocol,
         article: Article?)
    func setDate(_ publishedAt: String?) -> String
    func setArticle()
    func goToSafari()
}
// MARK: - DetailPresenter
class DetailPresenter: DetailViewPresenterProtocol {
    weak var view: DetailViewProtocol?
    var router: RouterProtocol?
    var article: Article?
    let networkService: NetworkServiceProtocol!
    
    required init(view: DetailViewProtocol,
                  networkService: NetworkManager,
                  router: RouterProtocol,
                  article: Article?) {
        self.view = view
        self.networkService = networkService
        self.article = article
        self.router = router
    }
    // MARK: - date type casting
    func setDate(_ publishedAt: String?) -> String {
        guard let publishedAt = publishedAt else { return "" }
        let formatter = DateFormatter()
        let date: Date = ISO8601DateFormatter().date(from: publishedAt) ?? Date()
        formatter.dateFormat = "MMM d, h:mm a"
        return formatter.string(from: date)
    }
    // MARK: - set the article data
    public func setArticle() {
        self.view?.setArticle(article: article)
    }
    // MARK: - display the article in the browser
    func goToSafari() {
        router?.showSafari(url: article?.url)
    }
}
