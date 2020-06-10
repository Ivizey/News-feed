//
//  HTTPTask.swift
//  NewsApp
//
//  Created by Pavel Bondar on 10.06.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String:String]

public enum HTTPTask {
    case request
    
    case requestHeaders(additionHeaders: HTTPHeaders?)
    
    case requestParameters(bodyParameters: Parameters?,
        urlParameters: Parameters?)
    
    case requestParametersAndHeaders(bodyParameters: Parameters?,
        urlParameters: Parameters?,
        additionHeaders: HTTPHeaders?)
}
