//
//  PhotoDetailsComponent.swift
//  LoremPicsumApp
//
//  Created by Aleksandr Kretov on 03.12.2022.
//

import UIKit
import NeedleFoundation

protocol PhotoDetailsDependency: Dependency {
    var fetcher: FetchingProtocol { get }
}

protocol PhotoDetailsBuilder {
    var photoDetailsViewController: PhotoDetailsViewController { get }
}

final class PhotoDetailsComponent: Component<PhotoDetailsDependency>, PhotoDetailsBuilder {
    var photoDetailsViewController: PhotoDetailsViewController {
        PhotoDetailsViewController(fetcher: dependency.fetcher)
    }
}
