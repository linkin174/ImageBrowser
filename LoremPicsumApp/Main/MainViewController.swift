//
//  MainViewController.swift
//  LoremPicsumApp
//
//  Created by Aleksandr Kretov on 14.11.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import SnapKit

protocol MainDisplayLogic: AnyObject {
    func display(viewModel: Main.ViewModel)
}

class MainViewController: UIViewController {
    
    var interactor: MainBusinessLogic?
    var router: (NSObjectProtocol & MainRoutingLogic & MainDataPassing)?
    
    //MARK: Private properties
    
    private var imageView: UIImageView = {
       let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        return indicator
    }()

    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: - Setup Clean Code Design Pattern 

    private func setup() {
        let viewController = self
        let interactor = MainInteractor(fetcher: NetworkFetcher(networkService: NetworkService()))
        let presenter = MainPresenter()
        let router = MainRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupConstaints() {
        view.addSubview(imageView)
        view.addSubview(loadingIndicator)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstaints()
        interactor?.makeRequest(request: .loadBackgroundImage)
    }
}

extension MainViewController: MainDisplayLogic {
    func display(viewModel: Main.ViewModel) {
        switch viewModel {
        case .displayBackgroundImage(let imageData, let error):
            if let imageData {
                DispatchQueue.main.async { [weak self] in
                    self?.imageView.image = UIImage(data: imageData)
                    self?.loadingIndicator.stopAnimating()
                }
            } else if let error {
                DispatchQueue.main.async { [weak self] in
                    let alert = UIAlertController(title: "OOPS",
                                                  message: "Something went wrong: \(error)",
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .destructive))
                    self?.present(alert, animated: true)
                }
            }
        }
    }
}