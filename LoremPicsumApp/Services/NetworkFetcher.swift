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
    
    func fetchRandomImage(of scale: Int) async throws -> Data {
        var method = ""
        switch scale {
        case 1: method = API.randomImage1x
        case 2: method = API.randomImage2x
        default: method = API.randomImage3x
        }
        do {
            return try await networkService.makeRequest(method, nil)
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


