//
//  ListOfGifsViewModel.swift
//  GifChallenge
//
//  Created by Mikalai on 10.03.2022.
//

import Foundation

protocol ListViewProtocol {
    func fetchAsync(_ identifier: UUID, completion: ((GifModel?, DisplayError?) -> Void)?)
    func fetchedData(for identifier: UUID) -> (GifModel?, DisplayError?)
    func cancelFetch(_ identifier: UUID)
}

final class ListViewModel: ListViewProtocol {

    // MARK: - Properties
    private var asyncFetcher: AsyncFetcherProtocol

    // MARK: - Initialization
    init(asyncFetcher: AsyncFetcher) {
        self.asyncFetcher = asyncFetcher
    }

    func fetchAsync(_ identifier: UUID, completion: ((GifModel?, DisplayError?) -> Void)? = nil) {
        asyncFetcher.fetchAsync(identifier) { fetchedData, errorData  in
            completion?(fetchedData, errorData)
        }
    }

    func fetchedData(for identifier: UUID) -> (GifModel?, DisplayError?) {
        asyncFetcher.fetchedData(for: identifier)
    }

    func cancelFetch(_ identifier: UUID) {
        asyncFetcher.cancelFetch(identifier)
    }
}
