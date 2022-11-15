//
//  RandomImageComponent.swift
//  LoremPicsumApp
//
//  Created by Aleksandr Kretov on 15.11.2022.
//

import UIKit
import NeedleFoundation

protocol RandomImageDependency: Dependency {
    var fetcher: NetworkFetcher { get }
}

protocol RandomImageBuilder {
    var randomImageViewController: UIViewController { get }
}

final class RandomImageComponent: Component<RandomImageDependency>, RandomImageBuilder {
    var randomImageViewController: UIViewController {
        RandomImageViewController(fetcher: dependency.fetcher)
    }
}
