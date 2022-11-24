//
//  GalleryPresenter.swift
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

protocol GalleryPresentationLogic {
    func present(photos: [Photo])
    func present(error: Error)
}

class GalleryPresenter: GalleryPresentationLogic {
    // MARK: - Public Properties
    weak var viewController: GalleryDisplayLogic?
    // MARK: - Public Methods
    func present(photos: [Photo]) {
        viewController?.display(photos: photos)
    }
    func present(error: Error) {
        if let error = error as? APIError {
            viewController?.display(errorMessage: error.rawValue)
        }
    }
}