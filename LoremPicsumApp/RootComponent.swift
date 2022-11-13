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
    
    var networkFetcher: NetworkFetcher {
        return shared { NetworkFetcher(networkService: networkService) }
    }
//
    var rootViewController: UIViewController {
        MainViewController()
    }

    var fetcherDiComponent: FetcherDiComponent {
        return FetcherDiComponent(parent: self)
    }

}
