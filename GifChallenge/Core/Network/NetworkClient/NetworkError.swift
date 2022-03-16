//
//  NetworkError.swift
//  GifChallenge
//
//  Created by Mikalai on 10.03.2022.
//

import Foundation

enum NetworkError: Error {
    case encodingFailed
    case missingURL
    case emptyData
    case jsonParsingFailure
    case serverError
    case clientError
    case redirectionError
    case connectionError
    case informationalError

    var localizedDescription: String {
        switch self {
        case .encodingFailed:
            return L10n.networkErrorEncodingFailedDescription.description
        case .missingURL:
            return L10n.networkErrorMissingURLDescription.description
        case .emptyData:
            return L10n.networkErrorEmptyDataDescription.description
        case .jsonParsingFailure:
            return L10n.networkErrorJsonParsingFailureDescription.description
        case .serverError:
            return L10n.networkErrorServerErrorDescription.description
        case .clientError:
            return L10n.networkErrorClientErrorDescription.description
        case .connectionError:
            return L10n.networkyErrorConnectionErrorDescription.description
        case .redirectionError:
            return L10n.networkErrorRedirectionErrorDescription.description
        case .informationalError:
            return L10n.networkErrorInformationalErrorDescription.description
        }
    }
}
