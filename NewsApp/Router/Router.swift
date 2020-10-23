//
//  Router.swift
//  NewsApp
//
//  Created by Pavel Bondar on 07.06.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit.UINavigationController
// MARK: - RouterMain
protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AsselderBuilderProtocol? { get set }
}
// MARK: - RouterProtocol
protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showDetail(article: Article?)
    func showSettings()
    func showSafari(url: URL?)
    func popToRoot()
}
// MARK: - Router
class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var assemblyBuilder: AsselderBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AsselderBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    // MARK: - push main view controller
    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = assemblyBuilder?.createNewsModule(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }
    // MARK: - push detail view controller
    func showDetail(article: Article?) {
        if let navigationController = navigationController {
            guard let detailViewController = assemblyBuilder?.createDetailModule(article: article, router: self) else { return }
            detailViewController.navigationItem.largeTitleDisplayMode = .never
            navigationController.pushViewController(detailViewController, animated: true)
        }
    }
    // MARK: - push settings view controller
    func showSettings() {
        if let navigationController = navigationController {
            guard let settingsViewController = assemblyBuilder?.createSettingsModule(router: self) else { return }
            settingsViewController.title = "Settings"
            navigationController.pushViewController(settingsViewController, animated: true)
        }
    }
    // MARK: - push safari view controller
    func showSafari(url: URL?) {
        let safari = SafariView()
        safari.showArticleInView(url: url)
    }
    // MARK: - back to the main view controller
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
