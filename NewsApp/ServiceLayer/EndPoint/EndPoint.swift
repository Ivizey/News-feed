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
    case country(letters: String)
    case category(category: String)
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
        case .country(let letters):
            return "v2/top-headlines?country=\(letters)"
        case .category(let category):
            return "/v2/top-headlines?country=de&category=\(category)"
        case .search(let q):
            return "v2/top-headlines?q=\(q)"
        }
    }
    
    var httpMethod: HTTPMethod {
        .get
    }
    
    var task: HTTPTask {
        switch self {
        case .country(let letters):
            return .requestParameters(bodyParameters: nil,
                                      urlParameters: ["country": letters,
                                                      "api_key":NetworkManager.NewsAPIKey])
            
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
