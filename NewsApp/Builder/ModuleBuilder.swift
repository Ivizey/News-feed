//
//  ModuleBuilder.swift
//  NewsApp
//
//  Created by Pavel Bondar on 07.06.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit.UIViewController
// MARK: - AsselderBuilderProtocol
protocol AsselderBuilderProtocol {
    func createNewsModule(router: RouterProtocol) -> UIViewController
    func createDetailModule(article: Article?, router: RouterProtocol) -> UIViewController
    func createSettingsModule(router: RouterProtocol) -> UIViewController
}
// MARK: - AsselderModelBuilder
class AsselderModelBuilder: AsselderBuilderProtocol {
    // MARK: - create news view controller
    func createNewsModule(router: RouterProtocol) -> UIViewController {
        let view = NewsView()
        let networkService = NetworkManager()
        let presenter = NewsPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
    // MARK: - create detail view controller
    func createDetailModule(article: Article?, router: RouterProtocol) -> UIViewController {
        let view = DetailViewController()
        let networkService = NetworkManager()
        let presenter = DetailPresenter(view: view, networkService: networkService, router: router, article: article)
        view.presenter = presenter
        return view
    }
    // MARK: - create settings view controller
    func createSettingsModule(router: RouterProtocol) -> UIViewController {
        let view = SettingsView()
        let presenter = SettingsPresenter(router: router)
        view.presenter = presenter
        return view
    }
}
