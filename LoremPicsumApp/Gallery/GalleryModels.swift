//
//  GalleryModels.swift
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

enum Gallery {
    enum Request {
        case fetchPhotos(page: Int, perPage: Int)
    }
    enum Response {
        case presentPhotos(photos: [Photo])
        case presentError(error: Error)
    }
    enum Display {
        case displayPhotos(photos: [Photo])
        case display(error: String)
    }
}
