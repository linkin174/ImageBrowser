//
//  RandomImageViewController.swift
//  LoremPicsumApp
//
//  Created by Aleksandr Kretov on 14.11.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import Combine
import SnapKit
import SwiftUI

private enum Constants {
    static let loadButtonDiameter: CGFloat = 60
    static let shareButtonDiameter: CGFloat = 40
    static let backButtonSize: CGFloat = 30
    static let bottomInset: CGFloat = 40
    static let topInset: CGFloat = 60

    static let strokeLineWidth: CGFloat = 5
    static let strokeColor: CGColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1).cgColor

    static let loadingAnimationDuration: Double = 0.2
    static let fadeAnimationDuration: Double = 0.4
}

protocol RandomImageDisplayLogic: AnyObject {
    func display(viewModel: RandomImage.ViewModel)
}

final class RandomImageViewController: UIViewController {
    // MARK: Private Properties

    private var interactor: RandomImageBusinessLogic?
    private let fetcher: FetchingProtocol
    private var isInterfaceHidden = false

    // MARK: Views

    private lazy var imageView: ZoomImageView = {
        let view = ZoomImageView()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideInterface))
        tapGesture.numberOfTapsRequired = 1
        if let gesture = view.gestureRecognizers?.first(where: { recognizer in
            guard
                let recognizer = recognizer as? UITapGestureRecognizer,
                recognizer.numberOfTapsRequired > 1
            else {
                return false
            }
            return true
        }) {
            tapGesture.require(toFail: gesture)
        }
        view.addGestureRecognizer(tapGesture)
        return view
    }()

    private lazy var loadButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        button.setImage(UIImage(systemName: "arrow.triangle.2.circlepath"), for: .normal)
        button.setImage(UIImage(), for: .selected)
        button.imageView?.tintColor = UIColor.white
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.layer.cornerRadius = Constants.loadButtonDiameter / 2
        button.dropShadow(color: .black, offsetX: 0, offsetY: 5)
        button.addTarget(self, action: #selector(loadImage), for: .touchUpInside)
        return button
    }()

    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.white
        button.setImage(UIImage(systemName: "square.and.arrow.up")?.withTintColor(.black), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 7, right: 0)
        button.dropShadow(color: .black, offsetX: 0, offsetY: 5)
        button.addTarget(self, action: #selector(shareImage), for: .touchUpInside)
        button.tintColor = .black
        return button
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setBackgroundImage(UIImage(systemName: "arrowshape.turn.up.backward.fill"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.tintColor = #colorLiteral(red: 0.1401333511, green: 0.3946738243, blue: 0.563154757, alpha: 1)
        button.dropShadow(color: .black, offsetX: 0, offsetY: 3, radius: 5)
        button.addTarget(self, action: #selector(tapBack), for: .touchUpInside)
        return button
    }()

    // MARK: Initializers

    init(fetcher: FetchingProtocol) {
        self.fetcher = fetcher
        super.init(nibName: nil, bundle: nil)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadImage()
    }

    // MARK: Private methods

    private func setup() {
        let viewController = self
        let interactor = RandomImageInteractor(fetcher: fetcher)
        let presenter = RandomImagePresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }

    private func setupConstraints() {
        view.addSubview(imageView)
        view.addSubview(loadButton)
        view.addSubview(shareButton)
        view.addSubview(backButton)

        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        loadButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(Constants.bottomInset)
            make.width.height.equalTo(Constants.loadButtonDiameter)
        }

        shareButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(40)
            make.bottom.equalToSuperview().inset(Constants.bottomInset)
            make.width.height.equalTo(Constants.shareButtonDiameter)
            shareButton.layer.cornerRadius = Constants.shareButtonDiameter / 2
        }

        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(Constants.topInset)
            make.width.height.equalTo(Constants.backButtonSize)
        }
    }

    private func animateImageChange(with image: UIImage) {
        UIView.transition(with: imageView,
                          duration: 0.7,
                          options: .transitionCrossDissolve) {
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }

    private func animateLoadButton() {
        let spinAnimation = CABasicAnimation(keyPath: "transform.rotation")
        spinAnimation.fromValue = 0
        spinAnimation.toValue = CGFloat.pi
        spinAnimation.duration = 1
        spinAnimation.repeatCount = .infinity
        loadButton.imageView?.layer.add(spinAnimation, forKey: "spin")
    }

    private func stopLoadButtonAnimation() {
        guard let layer = loadButton.imageView?.layer.presentation() else { return }
        guard let angle = layer.value(forKeyPath: "transform.rotation") as? CGFloat else { return }
        let spinAnimation = CABasicAnimation(keyPath: "transform.rotation")
        if angle > 2 {
            spinAnimation.fromValue = angle
            spinAnimation.toValue = CGFloat.pi
        }
        loadButton.imageView?.layer.add(spinAnimation, forKey: "spin")
    }

    // MARK: OBJC Methods

    @objc private func loadImage() {
        interactor?.makeRequest(request: .loadRandomImage)
        animateLoadButton()
        loadButton.isEnabled = false
        shareButton.isEnabled = false
    }

    @objc private func shareImage() {
        guard let image = imageView.image else { return }
        let shareVC = ShareViewController(activityItems: [image])
        present(shareVC, animated: false)
    }

    @objc private func hideInterface() {
        if isInterfaceHidden {
            shareButton.animateFade(.fadeIn, Constants.fadeAnimationDuration)
            loadButton.animateFade(.fadeIn, Constants.fadeAnimationDuration)
            backButton.animateFade(.fadeIn, Constants.fadeAnimationDuration)
        } else {
            shareButton.animateFade(.fadeOut, Constants.fadeAnimationDuration)
            loadButton.animateFade(.fadeOut, Constants.fadeAnimationDuration)
            backButton.animateFade(.fadeOut, Constants.fadeAnimationDuration)
        }
        isInterfaceHidden.toggle()
    }

    @objc private func tapBack() {
        dismiss(animated: true)
    }
}

// MARK: Extensions

extension RandomImageViewController: RandomImageDisplayLogic {
    func display(viewModel: RandomImage.ViewModel) {
        switch viewModel {
        case .displayRandom(let image):
            DispatchQueue.main.async { [unowned self] in
                self.shareButton.isEnabled = true
                self.loadButton.isEnabled = true
                self.stopLoadButtonAnimation()
                self.animateImageChange(with: image)
            }
        case .display(let error):
            showAlert("Error Loading Image", "Something went wrong: \(error). \n"
                + "Check your internet connection and try again")
        }
    }
}

// MARK: Preview

struct RandomImageVC_Previews: PreviewProvider {
    static var previews: some View {
        RandomImageViewController(fetcher: NetworkFetcher(networkService: NetworkService()))
            .makePreview()
    }
}
