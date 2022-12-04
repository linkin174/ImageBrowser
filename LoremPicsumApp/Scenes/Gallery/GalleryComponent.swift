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
    var galleryViewController: GalleryViewController { get }
}

final class GalleryComponent: Component<GalleryDependency>, GalleryBuilder {
    var galleryViewController: GalleryViewController {
        GalleryViewController(fetcher: dependency.fetcher, photoDetailsBuilder: detailsComponent)
    }

    var detailsComponent: PhotoDetailsComponent {
        PhotoDetailsComponent(parent: self)
    }
}
