//
//  ListOfGifsAssembley.swift
//  GifChallenge
//
//  Created by Mikalai on 10.03.2022.
//

import UIKit

enum ListAssembly {
    static func assembly() -> UIViewController {
        let networkClient = NetworkClient(config: .default)
        let asyncFetcher = AsyncFetcher(networkClient: networkClient)
        let viewModel = ListViewModel(asyncFetcher: asyncFetcher)
        let viewController = ListViewController(viewModel: viewModel)
        return viewController
    }
}
