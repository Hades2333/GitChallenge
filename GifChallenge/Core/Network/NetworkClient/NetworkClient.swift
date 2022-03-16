//
//  NetworkClient.swift
//  GifChallenge
//
//  Created by Mikalai on 10.03.2022.
//

import Foundation
import RxSwift
import SwiftyBeaver

protocol NetworkClientProtocol {
    func fetchGifs(with id: Int) -> Observable<GifDTO>
    func fetchRandomGif() -> Observable<GifDTO>
}

final class NetworkClient {

    // MARK: - Properties
    private lazy var jsonDecoder = JSONDecoder()
    private var urlSession: URLSession

    // MARK: - Initialization
    init(config: URLSessionConfiguration = URLSessionConfiguration.default) {
        urlSession = URLSession(configuration: config)
    }

    // MARK: - Observable
    private func callAPI<T: Decodable>(request: URLRequest) -> Observable<T> {

        return Observable.create { observer in

            let task = self.urlSession.dataTask(with: request) { (data, response, _) in
                guard response != nil else {
                    observer.onError(NetworkError.connectionError); return
                }

                if let httpResponse = response as? HTTPURLResponse {
                    let statusCode = httpResponse.statusCode

                    switch statusCode {
                    case 500...599:
                        observer.onError(NetworkError.serverError)
                    case 400...499:
                        observer.onError(NetworkError.clientError)
                    case 300...399:
                        observer.onError(NetworkError.redirectionError)
                    case 100...199:
                        observer.onError(NetworkError.redirectionError)
                    default:
                        do {
                            guard let data = data else { observer.onError(NetworkError.emptyData); return}
                            let randomGif = try self.jsonDecoder.decode(T.self, from: data)
                            SwiftyBeaver.info(randomGif)
                            observer.onNext(randomGif)
                        } catch {
                            SwiftyBeaver.warning(NetworkError.jsonParsingFailure.localizedDescription)
                            observer.onError(NetworkError.jsonParsingFailure)
                        }
                    }
                }
                observer.onCompleted()
            }
            task.resume()

            return Disposables.create {
                task.cancel()
            }
        }
    }
}

// MARK: - NetworkClientProtocol
extension NetworkClient: NetworkClientProtocol {
    func fetchGifs(with id: Int) -> Observable<GifDTO> {
        callAPI(request: NetworkRouter().configureURLRequest(with: MainEndpoint.getGif(id: id)))
    }
    func fetchRandomGif() -> Observable<GifDTO> {
        callAPI(request: NetworkRouter().configureURLRequest(with: MainEndpoint.randomGif))
    }
}
