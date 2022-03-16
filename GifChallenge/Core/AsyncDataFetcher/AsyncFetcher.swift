//
//  AsyncFetcher.swift
//  GifChallenge
//
//  Created by Mikalai on 11.03.2022.
//

import Foundation

protocol AsyncFetcherProtocol {
    func fetchAsync(_ identifier: UUID, completion: ((GifModel?, DisplayError?) -> Void)?)
    func fetchedData(for identifier: UUID) -> (GifModel?, DisplayError?)
    func cancelFetch(_ identifier: UUID)
}

final class AsyncFetcher: AsyncFetcherProtocol {

    // MARK: - Properties
    private let networkClient: NetworkClientProtocol
    private let serialAccessQueue = OperationQueue()
    private let fetchQueue = OperationQueue()
    private var completionHandlers = [UUID: [(GifModel?, DisplayError?) -> Void]]()
    private var cache = NSCache<NSUUID, GifModel>()

    // MARK: - Initialization
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
        serialAccessQueue.maxConcurrentOperationCount = 1
    }

    // MARK: - Methods
    func fetchAsync(_ identifier: UUID, completion: ((GifModel?, DisplayError?) -> Void)? = nil) {
        serialAccessQueue.addOperation {
            if let completion = completion {
                let handlers = self.completionHandlers[identifier, default: []]
                self.completionHandlers[identifier] = handlers + [completion]
            }
            self.fetchData(for: identifier)
        }
    }

    func fetchedData(for identifier: UUID) -> (GifModel?, DisplayError?) {
        return (cache.object(forKey: identifier as NSUUID), nil)
    }

    func cancelFetch(_ identifier: UUID) {
        serialAccessQueue.addOperation {
            self.fetchQueue.isSuspended = true
            defer {
                self.fetchQueue.isSuspended = false
            }
            self.operation(for: identifier)?.cancel()
            self.completionHandlers[identifier] = nil
        }
    }

    private func fetchData(for identifier: UUID) {
        guard operation(for: identifier) == nil else { return }

        if let data = fetchedData(for: identifier).0, fetchedData(for: identifier).1 == nil {
            invokeCompletionHandlers(for: identifier, with: data, with: nil)
        } else {
            let operation = AsyncFetcherOperation(identifier: identifier, networkClient: networkClient)
            operation.completionBlock = { [weak operation] in
                if let error = operation?.errorData {
                    self.serialAccessQueue.addOperation {
                        self.invokeCompletionHandlers(for: identifier, with: nil, with: error)
                    }
                    return
                }
                guard let fetchedData = operation?.fetchedData else { return }
                self.cache.setObject((fetchedData), forKey: identifier as NSUUID)

                self.serialAccessQueue.addOperation {
                    self.invokeCompletionHandlers(for: identifier, with: fetchedData, with: nil)
                }
            }
            fetchQueue.addOperation(operation)
        }
    }

    private func operation(for identifier: UUID) -> AsyncFetcherOperation? {
        for case let fetchOperation as AsyncFetcherOperation in fetchQueue.operations
        where !fetchOperation.isCancelled && fetchOperation.identifier == identifier {
            return fetchOperation
        }
        return nil
    }

    private func invokeCompletionHandlers(
        for identifier: UUID,
        with fetchedData: GifModel?,
        with errorData: DisplayError?
    ) {
        let completionHandlers = self.completionHandlers[identifier, default: []]
        self.completionHandlers[identifier] = nil

        for completionHandler in completionHandlers {
            completionHandler(fetchedData, errorData)
        }
    }
}
