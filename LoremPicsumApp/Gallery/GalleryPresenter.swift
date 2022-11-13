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
    func presentSomething(response: Gallery.Something.Response)
}

class GalleryPresenter: GalleryPresentationLogic {
    weak var viewController: GalleryDisplayLogic?

    // MARK: Parse and calc respnse from GalleryInteractor and send simple view model to GalleryViewController to be displayed

    func presentSomething(response: Gallery.Something.Response) {
        let viewModel = Gallery.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
//
//    func presentSomethingElse(response: Gallery.SomethingElse.Response) {
//        let viewModel = Gallery.SomethingElse.ViewModel()
//        viewController?.displaySomethingElse(viewModel: viewModel)
//    }
}
