//
//  UIViewController + Preview.swift
//  LoremPicsumApp
//
//  Created by Aleksandr Kretov on 14.11.2022.
//

import SwiftUI

extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        
        let viewController: UIViewController
        
        func makeUIViewController(context: Context) -> some UIViewController {
            viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    }
    
    func preview() -> some View {
        Preview(viewController: self).ignoresSafeArea()
    }
}
