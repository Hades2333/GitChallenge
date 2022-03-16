//
//  EndPointProtocol.swift
//  GifChallenge
//
//  Created by Mikalai on 10.03.2022.
//

import Foundation

protocol EndPointProtocol {
    var baseURL: URL? { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders { get }
}
