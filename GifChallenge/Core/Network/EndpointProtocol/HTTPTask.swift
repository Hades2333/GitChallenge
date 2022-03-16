//
//  HTTPTask.swift
//  GifChallenge
//
//  Created by Mikalai on 10.03.2022.
//

import Foundation

typealias HTTPHeaders = [String: String]

enum HTTPTask {
    case request
    case requestParameters(bodyParameters: Parameters?,
                           urlParameters: Parameters?)
    case requestParametersAndHeaders(
            bodyParameters: Parameters?,
            urlParameters: Parameters?,
            additionHeaders: HTTPHeaders
         )
}
