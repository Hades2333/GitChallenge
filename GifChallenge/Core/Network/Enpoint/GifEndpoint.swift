//
//  GifEndpoint.swift
//  GifChallenge
//
//  Created by Mikalai on 10.03.2022.
//

import Foundation

enum MainEndpoint: EndPointProtocol {
    case getGif(id: Int)
    case randomGif

    // MARK: - Private structs
    private struct APIConstants {
        static var userID = "e826c9fc5c929e0d6c6d423841a282aa"
        static var apiKey = "4IV2ouQC8RDMuONPt6UFn7y4uYCNZNdf"
    }

    // MARK: - Computed Properties
    var baseURL: URL? {
        URL(string: "https://api.giphy.com")
    }

    var path: String {
        switch self {
        case .getGif:
            return "v1/gifs"
        default:
            return "v1/gifs/random"
        }
    }
    var httpMethod: HTTPMethod {
        return .get
    }

    var task: HTTPTask {
        let parameters = [
            "random_id": APIConstants.userID,
            "api_key": APIConstants.apiKey
        ]
        return .requestParameters(bodyParameters: nil, urlParameters: parameters)
    }

    var headers: HTTPHeaders {
        return ["": ""]
    }
}
