//
//  PhotoCell.swift
//  LoremPicsumApp
//
//  Created by Aleksandr Kretov on 19.11.2022.
//

import UIKit
import SnapKit

final class PhotoCell: UICollectionViewCell {

    // MARK: Private properties

    private let indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        indicator.color = .white
        return indicator
    }()

    let imageView: WebImageView = {
        let imageView = WebImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "dummy")
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        return imageView
    }()

    // MARK: Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View Lifecycle

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setLayout()
        contentView.dropShadow(color: .black, offsetX: 2, offsetY: 4)
    }

    // MARK: Private methods

    private func setLayout() {
        contentView.addSubview(imageView)
        imageView.addSubview(indicator)

        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        indicator.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        }
    }

    // MARK: Public methods

    func setup(with imageURL: String?) {
        imageView.set(from: imageURL)
        indicator.stopAnimating()
    }
}
