//
//  RootDiComponent.swift
//  LoremPicsumApp
//
//  Created by Aleksandr Kretov on 13.11.2022.
//

import UIKit
import NeedleFoundation

final class RootComponent: BootstrapComponent {
    
    var networkService: NetworkingProtocol {
        return shared { NetworkService() }
    }
    
    var fetcher: NetworkFetcher {
        return shared { NetworkFetcher(networkService: networkService) }
    }
    
    var randomImageComponent: RandomImageComponent {
        RandomImageComponent(parent: self)
    }
    
    var galleryComponent: GalleryComponent {
        GalleryComponent(parent: self)
    }

    var rootViewController: UIViewController {
        MainViewController(fetcher: fetcher, randomImageBuilder: randomImageComponent, galleryBuilder: galleryComponent)
    }

    var fetcherDiComponent: FetcherDiComponent {
        return FetcherDiComponent(parent: self)
    }

}
