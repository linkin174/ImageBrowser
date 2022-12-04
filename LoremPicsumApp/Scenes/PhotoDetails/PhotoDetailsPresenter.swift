//
//  PhotoDetailsPresenter.swift
//  LoremPicsumApp
//
//  Created by Aleksandr Kretov on 03.12.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol PhotoDetailsPresentationLogic {
    func present(response: PhotoDetails.Response)
}

class PhotoDetailsPresenter: PhotoDetailsPresentationLogic {
    weak var viewController: PhotoDetailsDisplayLogic?

    func present(response: PhotoDetails.Response) {

        switch response {
        case .presentPreview(let previewImage):
            viewController?.display(viewModel: .displayPreview(previewImage: previewImage))
        case .presentPhoto(let photo):
            let size = "\(photo.width) x \(photo.height)"
            let url = URL(string: photo.url)
            let viewModel = PhotoViewModel(author: photo.author,
                                           url: url,
                                           downloadUrl: photo.downloadUrl,
                                           size: size,
                                           previewUrl: photo.previewUrl)
            viewController?.display(viewModel: .displayPhoto(photo: viewModel))
        }
    }
}
