//
//  MainModels.swift
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

enum Main {
    // MARK: Use cases

    enum Request {
        case loadBackgroundImage
    }

    enum Response {
        case presentBackgroundImage(data: Data)
        case presentError(error: Error)
    }

    enum Display {
        case displayBackgroundImage(image: UIImage)
        case displayError(text: String)
    }
}