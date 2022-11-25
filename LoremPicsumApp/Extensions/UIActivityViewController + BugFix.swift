//
//  UIActivityViewController + BugFix.swift
//  LoremPicsumApp
//
//  Created by Aleksandr Kretov on 25.11.2022.
//

import UIKit

// Before iOS 14.4 where is a bug that dismisses the parent VC after saving shared item

extension UIActivityViewController {
    override open func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        // do nothing to workaround bug - automatically dimisses this VC after saveToCameraRoll activity was performed
        // call super.dismiss(animated:completion:) in order to really dismiss this VC
        // seems fixed in iOS 14.4
    }

    @objc private func didTapCloseButton(_ sender: UIButton) {
        super.dismiss(animated: true) // calling parent class implementation
    }
}
