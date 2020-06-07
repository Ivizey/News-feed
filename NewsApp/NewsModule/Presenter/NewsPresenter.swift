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
    init(view: NewsViewProtocol, networkService: NetworkServiceProtocol)
    func getNews()
    var newsFeed: NewsFeed? { get set }
}

class NewsPresenter: NewsViewPresenterProtocol {
    weak var view: NewsViewProtocol?
    let networkService: NetworkServiceProtocol!
    var newsFeed: NewsFeed?
    
    required init(view: NewsViewProtocol, networkService: NetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        getNews()
    }
    
    func getNews() {
        networkService.getNews { [weak self] result in
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
