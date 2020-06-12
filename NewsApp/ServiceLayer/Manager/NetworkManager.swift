//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Pavel Bondar on 10.06.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import Foundation

fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> APIError {
    switch response.statusCode {
    case 200...299: return .success
    case 401...500: return .authenticationError
    case 501...599: return .badReguest
    case 600: return .outdated
    default: return .failed
    }
}

protocol NetworkServiceProtocol {
    func dataLoader<T: Decodable>(to endPoint: NewsApi, then handler: @escaping (Swift.Result<T, APIError>) -> Void)
}

struct NetworkManager: NetworkServiceProtocol {
    static let environment: NetworkEnvironment = .newsAPI
    static let newsAPIKey = "84a521a08cf141aa8bbe269df5f99439"
    private let router = NetworkRouter<NewsApi>()
    
    func dataLoader<T: Decodable>(to endPoint: NewsApi, then handler: @escaping (Swift.Result<T, APIError>) -> Void) {
        router.request(endPoint) { (data, response, error) in
            DispatchQueue.main.async {
                guard let httpResponse = response as? HTTPURLResponse else {
                    handler(.failure(.badReguest))
                    return
                }
                let result = handleNetworkResponse(httpResponse)
                switch result {
                case .success:
                    if let data = data {
                        do {
                            let objects = try JSONDecoder().decode(T.self, from: data)
                            handler(.success(objects))
                        } catch {
                            handler(.failure(.unableToDecode))
                        }
                    } else {
                        handler(.failure(.noData))
                    }
                default:
                    handler(.failure(result))
                }
            }
        }
    }
}
