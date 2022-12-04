//
//  ShareViewController.swift
//  LoremPicsumApp
//
//  Created by Aleksandr Kretov on 26.11.2022.
//

import UIKit

// Up to iOS 14.4 there is a bug in UIActivityViewController (There's rumors that 15+ also has this bug)
// It dissmisses parent view after shared item is saved
// To avoid that behaviour make subclass of regular UIViewController and make its background clear
// After that transparent VC is loaded present UIActivityViewController.
// After UIActivityViewController is dissmissed it will dissmiss parent view - TransparentVC

final class ShareViewController: UIViewController {

    private let activityItems: [Any]
    private let applicationActivities: [UIActivity]?

    // Same looking initializer as UIActivityViewController has
    init(activityItems: [Any], applicationActivities: [UIActivity]? = nil) {
        self.activityItems = activityItems
        self.applicationActivities = applicationActivities
        super.init(nibName: nil, bundle: nil)
        // Make transparent and covering entire screen
        view.backgroundColor = .clear
        modalPresentationStyle = .overCurrentContext
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Present UIActivityViewController here
        presentShareSheet()
    }

    private func presentShareSheet() {
        let shareSheet = UIActivityViewController(activityItems: activityItems,
                                                  applicationActivities: applicationActivities)
        shareSheet.completionWithItemsHandler = { [weak self] _, _, _, _ in
            // This is necessary to dismiss parent VC
            self?.dismiss(animated: false)
        }
        self.present(shareSheet, animated: true)
    }
}
