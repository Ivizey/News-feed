//
//  NetworkRouter.swift
//  NewsApp
//
//  Created by Pavel Bondar on 10.06.2020.
//  Copyright © 2020 Pavel Bondar. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

protocol NetworkRouterProtocol: class {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}
