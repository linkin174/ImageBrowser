//
//  Photo.swift
//  LoremPicsumApp
//
//  Created by Aleksandr Kretov on 19.11.2022.
//

import Foundation

struct Photo: Identifiable, Codable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: String
    let downloadUrl: String
    var previewUrl: String {
        let width = String(width / 10)
        let height = String(height / 10)
        return MainAPI.scheme + "://" + MainAPI.host + "/id/" + id + "/" + width + "/" + height
    }
}
