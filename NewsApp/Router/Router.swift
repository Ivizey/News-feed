//
//  Router.swift
//  NewsApp
//
//  Created by Pavel Bondar on 07.06.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit.UINavigationController

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AsselderBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showDetail(article: Article?)
}

class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var assemblyBuilder: AsselderBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AsselderBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = assemblyBuilder?.createNewsModule(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }
    
    func showDetail(article: Article?) {
        if let navigationController = navigationController {
            guard let detailViewController = assemblyBuilder?.createDetailModule(article: article, router: self) else { return }
            navigationController.pushViewController(detailViewController, animated: true)
        }
    }
}
