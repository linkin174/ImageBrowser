//
//  UIButton + Animation.swift
//  LoremPicsumApp
//
//  Created by Aleksandr Kretov on 16.11.2022.
//

import UIKit

enum FadeType {
    case fadeIn, fadeOut
}

extension UIView {
    func animateFade(_ animationType: FadeType, _ duration: Double) {
        var opacity: CGFloat = 0

        UIView.animate(withDuration: duration,
                       delay: 0,
                       options: [.curveEaseInOut]) {
            switch animationType {
            case .fadeIn:
                opacity = 1
            case .fadeOut:
                opacity = 0
            }
            self.alpha = opacity
        }
    }
}
