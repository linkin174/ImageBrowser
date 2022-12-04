//
//  UIViewController + TopBarHeight.swift
//  LoremPicsumApp
//
//  Created by Aleksandr Kretov on 04.12.2022.
//

import UIKit

extension UIViewController {

    var topBarHeight: CGFloat {
        var topHeight = navigationController?.navigationBar.frame.height ?? 0
        if #available(iOS 15.0, *) {
            let scene = view.window?.windowScene?.windows.first?.windowScene
            let height = scene?.statusBarManager?.statusBarFrame.height
            topHeight += height ?? 0
        } else if #available(iOS 13.0, *) {
            topHeight += UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            topHeight += UIApplication.shared.statusBarFrame.height
        }
        return topHeight
    }
}
