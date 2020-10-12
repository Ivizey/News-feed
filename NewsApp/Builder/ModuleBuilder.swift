//
//  ModuleBuilder.swift
//  NewsApp
//
//  Created by Pavel Bondar on 07.06.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit.UIViewController

protocol AsselderBuilderProtocol {
    func createNewsModule(router: RouterProtocol) -> UIViewController
    func createDetailModule(article: Article?, router: RouterProtocol) -> UIViewController
    func createSettingsModule() -> UIViewController
}

class AsselderModelBuilder: AsselderBuilderProtocol {    
    func createNewsModule(router: RouterProtocol) -> UIViewController {
        let view = NewsView()
        let networkService = NetworkManager()
        let safariService = SafariService()
        let activityService = ActivityViewService()
        let presenter = NewsPresenter(view: view, networkService: networkService, router: router, safariService: safariService, activityService: activityService)
        view.presenter = presenter
        return view
    }
    
    func createDetailModule(article: Article?, router: RouterProtocol) -> UIViewController {
        let view = DetailViewController()
        let networkService = NetworkManager()
        let safariService = SafariService()
        let presenter = DetailPresenter(view: view, networkService: networkService, router: router, article: article, safariService: safariService)
        view.presenter = presenter
        return view
    }
    
    func createSettingsModule() -> UIViewController {
        return SettingsView()
    }
}
