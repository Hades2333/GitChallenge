//
//  DisplayError.swift
//  GifChallenge
//
//  Created by Mikalai on 12.03.2022.
//

import Foundation

final class DisplayError: NSObject {

    // MARK: - Properties
    private var error: NetworkError

    var errorName: String {
        switch error {
        case .clientError:
            return L10n.displayErrorClientErrorName.description
        case .emptyData:
            return L10n.displayErrorEmptyDataName.description
        case .encodingFailed:
            return L10n.displayErrorEncodingFailedName.description
        case .jsonParsingFailure:
            return L10n.displayErrorJsonParsingFailureName.description
        case .missingURL:
            return L10n.displayErrorMissingURLName.description
        case .serverError:
            return L10n.displayErrorServerErrorName.description
        case .connectionError:
            return L10n.displayErrorConnectionErrorName.description
        case .redirectionError:
            return L10n.displayErrorRedirectionErrorName.description
        case .informationalError:
            return L10n.displayErrorInformationalErrorName.description
        }
    }

    var errorDescription: String {
        return error.localizedDescription
    }

    // MARK: - Initialization
    init(error: NetworkError) {
        self.error = error
        super.init()
    }
}
