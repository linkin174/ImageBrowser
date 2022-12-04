//
//  WebImageView.swift
//  LoremPicsumApp
//
//  Created by Aleksandr Kretov on 19.11.2022.
//

import UIKit

final class WebImageView: UIImageView {

    private var currentUrlString: String?

    func set(from stringURL: String?) {
        guard let stringURL = stringURL, let url = URL(string: stringURL) else {
            self.image = nil
            return }
        if let urlCache = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            let image = UIImage(data: urlCache.data)
            animateImageChange(image)
            return
        }

        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, _ in
            DispatchQueue.main.async {
                if let data = data, let response = response {
                    self?.currentUrlString = response.url?.absoluteString
                    self?.handedLoadedImage(data: data, response: response)
                }
            }
        }
        dataTask.resume()
    }

    private func handedLoadedImage(data: Data, response: URLResponse) {
        guard let responseURL = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseURL))

        if responseURL.absoluteString == currentUrlString {
            let image = UIImage(data: data)
            animateImageChange(image)
        }
    }

    private func animateImageChange(_ image: UIImage?) {
        UIView.transition(with: self, duration: 0.6, options: .transitionCrossDissolve) {
            self.image = image
        }
    }
}
