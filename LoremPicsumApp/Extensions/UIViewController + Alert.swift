//
//  UIViewController + Alert.swift
//  LoremPicsumApp
//
//  Created by Aleksandr Kretov on 16.11.2022.
//

import UIKit

extension UIViewController {
    func showAlert(_ title: String, _ message: String) {
        let alert = UIAlertController()
        let action = UIAlertAction(title: "Close", style: .default)
        alert.addAction(action)
        alert.title = title
        alert.message = message
        present(alert, animated: true)
    }
}
