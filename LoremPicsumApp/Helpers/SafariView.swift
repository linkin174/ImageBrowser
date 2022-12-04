//
//  SafariView.swift
//  LoremPicsumApp
//
//  Created by Aleksandr Kretov on 04.12.2022.
//

import UIKit
import WebKit

final class SafariView: UIViewController, WKUIDelegate {

    var url: URL?

    private var webView: WKWebView!

    override func loadView() {
        super.loadView()
        let config = WKWebViewConfiguration()
        webView = WKWebView(frame: view.frame, configuration: config)
        webView.uiDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadURL()
    }

    init(url: URL?) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func loadURL() {
        guard let url else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
