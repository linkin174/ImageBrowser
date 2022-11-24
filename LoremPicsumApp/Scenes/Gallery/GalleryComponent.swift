//
//  GalleryComponent.swift
//  LoremPicsumApp
//
//  Created by Aleksandr Kretov on 15.11.2022.
//

import UIKit
import NeedleFoundation

protocol GalleryDependency: Dependency {
    var fetcher: FetchingProtocol { get }
}

protocol GalleryBuilder {
    var galleryViewController: UIViewController { get }
}

final class GalleryComponent: Component<GalleryDependency>, GalleryBuilder {
    var galleryViewController: UIViewController {
        GalleryViewController(fetcher: dependency.fetcher)
    }
}
