//
//  GifCell.swift
//  GifChallenge
//
//  Created by Mikalai on 11.03.2022.
//

import UIKit
import SnapKit
import SDWebImageWebPCoder

final class GifCell: UICollectionViewCell {

    // MARK: - Properties
    var representedIdentifier: UUID?

    // MARK: - GUI variables
    lazy var spinner: UIActivityIndicatorView = {
        let item = UIActivityIndicatorView(style: .large)
        item.color = .black
        item.startAnimating()
        return item
    }()

    lazy private var imageView: UIImageView = {
        let item = UIImageView()
        item.backgroundColor = .white
        return item
    }()

    lazy private var label: UILabel = {
        let item = UILabel()
        item.textAlignment = .left
        item.textColor = .white
        item.font = UIFont.boldSystemFont(ofSize: 30)
        item.backgroundColor = .black
        return item
    }()

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration
    func configure(with data: GifModel?) {
        guard let data = data else {
            DispatchQueue.main.async {
                self.imageView.image = nil
                self.label.text?.removeAll()
            }
            return
        }

        let webPCoder = SDImageWebPCoder.shared
        SDImageCodersManager.shared.addCoder(webPCoder)

        guard let url = URL(string: data.imageURL) else { return }
        imageView.sd_setImage(with: url) { image, _, _, _ in
            DispatchQueue.main.async {
                self.imageView.image = image
                self.label.text = data.text
                self.spinner.stopAnimating()
            }
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
        self.label.text?.removeAll()
    }

    // MARK: - Private methods
    private func configureUI() {
        [imageView, label, spinner].forEach({addSubview($0)})

        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        label.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(10)
            $0.right.lessThanOrEqualToSuperview()
        }
        spinner.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
