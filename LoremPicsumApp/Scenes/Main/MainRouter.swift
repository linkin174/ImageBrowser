//
//  MainRouter.swift
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

@objc protocol MainRoutingLogic {
    func routeToRandomImageVC()
    func routeToGalleryVC()
}

protocol MainDataPassing {
    var dataStore: MainDataStore? { get }
}

final class MainRouter: NSObject, MainRoutingLogic, MainDataPassing {

    // MARK: - Public Properties

    weak var viewController: MainViewController?
    var dataStore: MainDataStore?

    // MARK: Routing (navigating to other screens)

    func routeToRandomImageVC() {
        guard let source = viewController else { return }
        guard let destination = viewController?.randomImageBuilder?.randomImageViewController else { return }
        presentSomeVC(source: source, destination: destination)
    }

    func routeToGalleryVC() {
        let tabItemsRepresentations: [(title: String, image: String)] = [
            (title: "Gallery", image: "photo.fill.on.rectangle.fill"),
            (title: "Favorites", image: "heart.fill"),
            (title: "About", image: "questionmark.circle.fill")
        ]
        guard let source = viewController else { return }
        guard let destination = source.galleryBuilder?.galleryViewController else { return }
        #warning("Try to move logic of creating TabBar in GalleryVC")
        let tabVC = UITabBarController()
        let galleryVC = UINavigationController(rootViewController: destination)
        let favoritesVC = UINavigationController(rootViewController: FavoritesViewController())
        let aboutVC = AboutViewController()
        tabVC.setViewControllers([galleryVC, favoritesVC, aboutVC], animated: true)
        guard let items = tabVC.tabBar.items else { return }
        for index in 0..<items.count {
            items[index].title = tabItemsRepresentations[index].title
            items[index].image = UIImage(systemName: tabItemsRepresentations[index].image)
        }
        presentSomeVC(source: source, destination: tabVC)
    }

    // MARK: Navigation to other screen

    private func navigateToSomewhere(source: UIViewController, destination: UIViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }

    private func presentSomeVC(source: UIViewController, destination: UIViewController) {
        destination.modalPresentationStyle = .fullScreen
        source.present(destination, animated: true)
    }
}
