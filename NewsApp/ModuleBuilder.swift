//
//  ModuleBuilder.swift
//  NewsApp
//
//  Created by Pavel Bondar on 07.06.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import UIKit.UIViewController

protocol Builder {
    static func createNews() -> UIViewController
}

class ModelBuilder: Builder {
    static func createNews() -> UIViewController {
        return NewsViewController()
    }
}
