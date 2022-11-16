//
//  NetworkFetcher.swift
//  LoremPicsumApp
//
//  Created by Aleksandr Kretov on 13.11.2022.
//

import Foundation
import NeedleFoundation
import UIKit.UIImage

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

final class NetworkFetcher {
    
    private let networkService: NetworkingProtocol
    
    init(networkService: NetworkingProtocol) {
        self.networkService = networkService
    }
    
    func fetchRandomImage() async throws -> Data {
        do {
            return try await networkService.makeRequest(API.randomImage, nil)
        } catch let error {
            throw error
        }
    }
    
    private func decode<T: Decodable>(from data: Data, to type: T.Type) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let decoded = try? decoder.decode(type, from: data) else { throw APIError.badDecoding }
        return decoded
    }
}


