//
//  ListOfGifsViewController.swift
//  GifChallenge
//
//  Created by Mikalai on 10.03.2022.
//

import UIKit
import SnapKit
import RxSwift

final class ListViewController: UIViewController {

    // MARK: - Models
    private struct Model {
        var identifier = UUID()
    }

    // MARK: - Properties
    private var listViewModel: ListViewProtocol?

    private let models = (1...Int(UInt16.max)).map { _ in
        return Model()
    }

    // MARK: - GUI variables
    lazy private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 15
        let screenSize = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: screenSize, height: screenSize)

        let item = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        item.showsVerticalScrollIndicator = false
        item.backgroundColor = .black
        item.register(GifCell.self, forCellWithReuseIdentifier: GifCell.identifier())
        return item
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        configureUI()
    }

    // MARK: - Initialization
    init(viewModel: ListViewProtocol) {
        self.listViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private methods
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(collectionView)

        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension ListViewController {
    func showAlert(with error: DisplayError) {
        self.showAlert(alertText: error.errorName, alertMessage: error.errorDescription)
    }
}

// MARK: UICollectionViewDataSourcePrefetching
extension ListViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            let model = models[indexPath.row]
            listViewModel?.fetchAsync(model.identifier, completion: nil)
        }
    }
}

// MARK: UICollectionViewDataSource
extension ListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(UInt16.max)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: GifCell.identifier(),
            for: indexPath
        ) as? GifCell else {
            return UICollectionViewCell()
        }

        DispatchQueue.main.async {
            cell.spinner.startAnimating()
        }

        let model = models[indexPath.row]
        let identifier = model.identifier
        cell.representedIdentifier = identifier

        if let fetchedData =
            listViewModel?.fetchedData(for: identifier).0 {
            cell.configure(with: fetchedData)
            return cell
        } else {
            cell.configure(with: nil)

            listViewModel?.fetchAsync(identifier) { fetchedData, errorData  in
                DispatchQueue.main.async { [weak self] in
                    guard let self = self, cell.representedIdentifier == identifier else { return }
                    if let error = errorData {
                        self.showAlert(with: error)
                    }
                    cell.configure(with: fetchedData)
                }
            }
        }
        return cell
    }
}
