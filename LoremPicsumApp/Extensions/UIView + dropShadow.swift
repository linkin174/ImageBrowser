//
//  UIView + dropShadow.swift
//  LoremPicsumApp
//
//  Created by Aleksandr Kretov on 17.11.2022.
//

import UIKit

extension UIView {
    func dropShadow(color: UIColor, offsetX: CGFloat, offsetY: CGFloat,  opacity: Float = 0.5,  radius: CGFloat = 5) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: offsetX, height: offsetY)
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
