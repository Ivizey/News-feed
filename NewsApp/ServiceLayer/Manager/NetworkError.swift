//
//  NetworkError.swift
//  NewsApp
//
//  Created by Pavel Bondar on 10.06.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import Foundation

enum APIError: Error {
    case success
    case authenticationError
    case badReguest
    case outdated
    case failed
    case noData
    case unableToDecode
    
    var localizedDescription: String {
        switch self {
        case .success: return ""
        case .authenticationError: return "You need to be authenticated first."
        case .badReguest: return "Bad reguest"
        case .outdated: return "The url you requested is outdated."
        case .failed: return "Network request failed."
        case .noData: return "Response returned with no data to decode."
        case .unableToDecode: return "We could not decode the response."
        }
    }
}
