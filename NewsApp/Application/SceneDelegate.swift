//
//  SceneDelegate.swift
//  NewsApp
//
//  Created by Pavel Bondar on 10/27/19.
//  Copyright © 2019 Pavel Bondar. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let titleAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let navigationController = UINavigationController()
        navigationController.navigationBar.barTintColor = #colorLiteral(red: 0.1912669241, green: 0.2193436921, blue: 0.2402234972, alpha: 1)
        navigationController.navigationBar.backgroundColor = #colorLiteral(red: 0.1912669241, green: 0.2193436921, blue: 0.2402234972, alpha: 1)
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationItem.largeTitleDisplayMode = .always
        navigationController.navigationBar.largeTitleTextAttributes = titleAttributes
        navigationController.navigationBar.titleTextAttributes = titleAttributes
        
        let assemblyBuilder = AsselderModelBuilder()
        let router = Router(navigationController: navigationController, assemblyBuilder: assemblyBuilder)
        router.initialViewController()
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
