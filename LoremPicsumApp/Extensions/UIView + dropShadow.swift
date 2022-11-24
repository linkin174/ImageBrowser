//
//  UIView + dropShadow.swift
//  LoremPicsumApp
//
//  Created by Aleksandr Kretov on 17.11.2022.
//

import UIKit

extension UIView {
    func dropShadow(color: UIColor, offsetX: CGFloat, offsetY: CGFloat, opacity: Float = 0.5, radius: CGFloat = 5) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = CGSize(width: offsetX, height: offsetY)
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}
