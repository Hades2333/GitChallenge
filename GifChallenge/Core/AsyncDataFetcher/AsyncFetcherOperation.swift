//
//  AsyncFetcherOperation.swift
//  GifChallenge
//
//  Created by Mikalai on 11.03.2022.
//

import UIKit
import RxSwift

final class AsyncFetcherOperation: Operation {

    // MARK: - Properties
    private(set) var fetchedData: GifModel?
    private(set) var errorData: DisplayError?

    private let networkClient: NetworkClientProtocol
    private let disposedBag = DisposeBag()
    let identifier: UUID

    private var _isFinished: Bool = false
    override var isFinished: Bool {
        get {
            return _isFinished
        }
        set {
            if _isFinished != newValue {
                willChangeValue(forKey: "isFinished")
                _isFinished = newValue
                didChangeValue(forKey: "isFinished")
            }
        }
    }

    // MARK: - Initialization
    init(identifier: UUID, networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
        self.identifier = identifier
    }

    // MARK: - Operation overrides
    override func main() {
        guard !isCancelled else { return }

        self.networkClient.fetchRandomGif().subscribe { gif in
            self.fetchedData = GifModel(
                imageURL: gif.data.images.original.webp,
                text: gif.data.title
            )
            self.isFinished = true
        }
        onError: { item in
            guard let item = item as? NetworkError else { return }
            self.errorData = DisplayError(error: item)
            self.isFinished = true
        }.disposed(by: self.disposedBag)
    }
}
