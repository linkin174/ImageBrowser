//
//  ZoomImageView.swift
//  LoremPicsumApp
//
//  Created by Aleksandr Kretov on 03.12.2022.
//

import UIKit
import SnapKit

final class ZoomImageView: UIScrollView {

    // MARK: Public properties

    var image: UIImage? {
        didSet {
            transitionImageChange(with: image)
        }
    }

    // MARK: Private properties

    private var transitionType: AnimationOptions

    private let imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "dummy")
        view.contentMode = .scaleAspectFill
        return view
    }()

    // MARK: Initializers

    init(frame: CGRect, minZoom: CGFloat = 1, maxZoom: CGFloat = 3,
         transitionType: AnimationOptions = .transitionCrossDissolve) {
        self.transitionType = transitionType
        super.init(frame: frame)

        addSubview(imageView)
        setImageViewConstraints()
        addGestureRecognizers()

        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        maximumZoomScale = maxZoom
        minimumZoomScale = minZoom
        bouncesZoom = false
        delegate = self
    }

    convenience init () {
        self.init(frame: .zero, minZoom: 1, maxZoom: 3, transitionType: .transitionCrossDissolve)
    }

    convenience init(maxZoom: CGFloat) {
        self.init(frame: .zero, minZoom: 1, maxZoom: maxZoom, transitionType: .transitionCrossDissolve)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private methods

    private func setImageViewConstraints() {
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.edges.equalToSuperview()
        }
    }

    private func addGestureRecognizers() {
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(restoreZoom))
        doubleTapGesture.numberOfTapsRequired = 2
        addGestureRecognizer(doubleTapGesture)
    }

    private func transitionImageChange(with image: UIImage?) {
        guard let image else { return }
        UIView.transition(with: imageView,
                          duration: 0.7,
                          options: transitionType) {
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }

    // MARK: ObjC private methods

    @objc private func restoreZoom() {
        UIView.animate(withDuration: 0.5) {
            self.zoomScale = self.minimumZoomScale
        }
    }
}

// MARK: Extensions

extension ZoomImageView: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageView
    }
}
