//
//  API.swift
//  LoremPicsumApp
//
//  Created by Aleksandr Kretov on 14.11.2022.
//

import Foundation
import UIKit

let screen = UIScreen.main.bounds

struct API {
    static let scheme = "https"
    static let host = "picsum.photos"
    static let listPhotos = "/v2/list"
    static let randomImage1x = "/\(Int(screen.maxX))/\(Int(screen.maxY))"
    static let randomImage2x = "/\(Int(screen.maxX) * 2)/\(Int(screen.maxY) * 2)"
    static let randomImage3x = "/\(Int(screen.maxX) * 3)/\(Int(screen.maxY) * 3)"
}
