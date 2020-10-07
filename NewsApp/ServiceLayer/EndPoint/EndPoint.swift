//
//  EndPoint.swift
//  NewsApp
//
//  Created by Pavel Bondar on 10.06.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    case newsAPI
}

public enum NewsApi {
    case country(country: String, page: Int)
    case category(country: String,category: String)
    case search(q: String)
}

extension NewsApi: EndPointType {
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .newsAPI: return "https://newsapi.org/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .country(let letters, let page):
            return "v2/top-headlines?country=\(letters)&page=\(page)"
        case .category(let country, let category):
            return "/v2/top-headlines?country=\(country)&category=\(category)"
        case .search(let q):
            return "v2/everything?q=\(q)&sortBy=publishedAt"
        }
    }
    
    var httpMethod: HTTPMethod {
        .get
    }
    
    var task: HTTPTask {
        switch self {
        case .country(let letters, let page):
            return .requestParameters(bodyParameters: nil, urlParameters: ["country": letters, "page": page,
                                                                           "apiKey":NetworkManager.newsAPIKey])
        case .search(let q): return .requestParameters(bodyParameters: nil, urlParameters: ["q": q,
                                                                            "apiKey":NetworkManager.newsAPIKey])
            
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
