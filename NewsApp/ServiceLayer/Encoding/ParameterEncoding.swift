//
//  ParameterEncoding.swift
//  NewsApp
//
//  Created by Pavel Bondar on 10.06.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import Foundation

public typealias Parameters = [String:Any]

public protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

public enum NetworkError: String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil."
}
