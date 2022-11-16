//
//  UIButton + Animation.swift
//  LoremPicsumApp
//
//  Created by Aleksandr Kretov on 16.11.2022.
//

import UIKit

extension UIButton {
    
    func animateFade(_ animationType: ButtonAnimationType, _ duration: Double) {
        UIView.animate(withDuration: duration,
                       delay: 0,
                       options: [.curveEaseInOut]) {
            var opacity: Float = 0
            switch animationType {
            case .fadeIn:
                opacity = 1
            case .fadeOut:
                opacity = 0
            }
            self.layer.opacity = opacity
        }
    }
}

enum ButtonAnimationType {
    case fadeIn, fadeOut
}
