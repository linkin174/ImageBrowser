//
//  NetworkFetcher.swift
//  LoremPicsumApp
//
//  Created by Aleksandr Kretov on 13.11.2022.
//

import Foundation
import NeedleFoundation
import UIKit.UIImage
import Combine

protocol FetcherDependency: Dependency {
    var networkService: NetworkingProtocol { get }
}

protocol FetcherBuilder {
    var networkFetcher: NetworkFetcher { get }
}

final class FetcherDiComponent: Component<FetcherDependency>, FetcherBuilder {
    var networkFetcher: NetworkFetcher {
        NetworkFetcher(networkService: dependency.networkService)
    }
}

protocol FetchingProtocol {
    func fetchRandomImage() async throws -> Data
    func fetchPhotos(page: Int?, limit: Int?) async throws -> [Photo]
    func fetchRandomImageData(completion: @escaping (Result<Data, Error>) -> Void)
}

final class NetworkFetcher: FetchingProtocol {

    private var cancellables = Set<AnyCancellable>()

    private var observer: AnyCancellable?

    private let networkService: NetworkingProtocol

    init(networkService: NetworkingProtocol) {
        self.networkService = networkService
    }

    /// Fetches a random image data from API
    ///
    /// See ``API`` for more information
    ///
    /// > Warning: Can throw Error instead of returning Data
    ///
    /// - Parameters:
    ///     - no parameters needed
    ///
    /// - Returns: Return image data of random image from API
    func fetchRandomImage() async throws -> Data {
        do {
            #warning("test")
            networkService.makeRequestWithCompletion(API.randomImage, nil) { result in
                print(result)
            }
            return try await networkService.makeRequest(API.randomImage, nil)
        } catch let error {
            throw error
        }
    }

    /// Fetch target number of photos on target page, if given
    ///
    /// ```
    /// fetchPhotos(page: 1, limit: nil)
    /// // return array of 30 photos of first page
    /// fetchPhotos(page: nil, limit: 100)
    /// // return 100 photos from first page
    /// ```
    ///
    /// > Warning: Maximum photos per page allowed equals 100.
    /// > Everything above 100 would be ignored
    ///
    /// - Throws: Method can throw ``APIError``
    ///
    /// - Parameters:
    ///     - page: Selected page to load from, default = 1
    ///     - limit: Limits number of ``Photo`` from selected page, default = 30
    ///
    /// - Returns: ``[Photo]``
    func fetchPhotos(page: Int?, limit: Int?) async throws -> [Photo] {
        var parameters = [String: String]()
        if let page {
            parameters["page"] = String(page)
        }
        if let limit {
            parameters["limit"] = String(limit)
        }
        do {
            let data = try await networkService.makeRequest(API.listPhotos, parameters)
            let photos = try decode(from: data, to: [Photo].self)
            return photos
        } catch let error {
            throw error
        }
    }

    func fetchRandomImageData(completion: @escaping (Result<Data, Error>) -> Void) {
        networkService.makeRequestWithCompletion(API.randomImage, nil, completion: completion)
    }

    private func decode<T: Decodable>(from data: Data, to type: T.Type) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let decoded = try? decoder.decode(type, from: data) else { throw APIError.badDecoding }
        return decoded
    }
}
