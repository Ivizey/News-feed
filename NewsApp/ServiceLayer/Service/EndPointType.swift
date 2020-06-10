//
//  EndPointType.swift
//  NewsApp
//
//  Created by Pavel Bondar on 10.06.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
