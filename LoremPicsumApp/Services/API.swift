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
    static let randomImage = "/\(Int(screen.maxX) * 3)/\(Int(screen.maxY) * 3)"
}
