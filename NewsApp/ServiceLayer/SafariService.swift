//
//  SafariService.swift
//  NewsApp
//
//  Created by Pavel Bondar on 18.06.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import Foundation
import SafariServices

protocol SafariServiceProtocol {
    func showNewsInBrowser(url: URL?)
}

class SafariService: SafariServiceProtocol {
    func showNewsInBrowser(url: URL?) {
        if let url = url {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true

            let safariView = SFSafariViewController(url: url, configuration: config)
            let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
            keyWindow?.rootViewController?.present(safariView, animated: true, completion: nil)
        }
    }
}
