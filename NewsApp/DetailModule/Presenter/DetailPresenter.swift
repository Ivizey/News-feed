//
//  DetailPresenter.swift
//  NewsApp
//
//  Created by Pavel Bondar on 07.06.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import Foundation

protocol DetailViewProtocol: class {
    func setArticle(article: Article?)
}

protocol DetailViewPresenterProtocol: class {
    init(view: DetailViewProtocol, networkService: NetworkService, article: Article?)
    func setArticle()
}

class DetailPresenter: DetailViewPresenterProtocol {
    weak var view: DetailViewProtocol?
    let networkService: NetworkServiceProtocol!
    var article: Article?
    
    required init(view: DetailViewProtocol, networkService: NetworkService, article: Article?) {
        self.view = view
        self.networkService = networkService
        self.article = article
    }
    
    public func setArticle() {
        self.view?.setArticle(article: article)
    }
}
