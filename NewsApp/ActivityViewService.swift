//
//  ActivityViewService.swift
//  NewsApp
//
//  Created by Pavel Bondar on 18.06.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import Foundation
import UIKit.UIApplication

protocol ActivityViewServiceProtocol {
    func shareNews(url: URL?)
}

class ActivityViewService: ActivityViewServiceProtocol {
    func shareNews(url: URL?) {
        guard let url = url else { return }
        let activityView = UIActivityViewController(activityItems: [url], applicationActivities: [])
        let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
        keyWindow?.rootViewController?.present(activityView, animated: true, completion: nil)
    }
}
