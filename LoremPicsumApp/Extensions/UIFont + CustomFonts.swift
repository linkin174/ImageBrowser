//
//  UIFont + CustomFonts.swift
//  LoremPicsumApp
//
//  Created by Aleksandr Kretov on 04.12.2022.
//

import UIKit

extension UIFont {
    public class func sparkyStones(of size: CGFloat) -> UIFont {
        UIFont(name: "SparkyStones-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
