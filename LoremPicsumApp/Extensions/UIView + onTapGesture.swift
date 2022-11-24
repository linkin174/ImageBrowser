//
//  UIView + onTapGesture.swift
//  LoremPicsumApp
//
//  Created by Aleksandr Kretov on 16.11.2022.
//

import UIKit

extension UIView {
    func onTapGesture(_ target: Any?, _ action: Selector) {
        let recognizer = UITapGestureRecognizer(target: target, action: action)
        addGestureRecognizer(recognizer)
    }
}
