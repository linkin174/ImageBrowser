//
//  NetworkService.swift
//  LoremPicsumApp
//
//  Created by Aleksandr Kretov on 13.11.2022.
//

import Foundation

enum APIError: String, Error {
    case badURL = "Bad url for request"
    case noResponse = "Server is not responding"
    case badResponse
    case noData
    case badDecoding
}

protocol NetworkingProtocol {
    func makeRequest(_ method: String, _ parameters: [String: String]?)  async throws -> Data
}

final class NetworkService: NetworkingProtocol {

    func makeRequest(_ method: String, _ parameters: [String: String]? = nil) async throws -> Data {
        guard let url = createURL(method, parameters) else { throw APIError.badURL }
        var request = URLRequest(url: url)
        request.timeoutInterval = 10
        request.cachePolicy = .reloadRevalidatingCacheData
        do {
            let result: (data: Data, response: URLResponse)? = try? await URLSession.shared.data(for: request)
            guard let response = result?.response as? HTTPURLResponse else { throw APIError.noResponse }
            guard 200...299 ~= response.statusCode else { throw APIError.badResponse }
            guard let data = result?.data else { throw APIError.noData }
            return data
        } catch let error {
            throw error
        }
    }

    private func createURL(_ method: String, _ parameters: [String: String]?) -> URL? {
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = method
        if let parameters {
            components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
        }
        print(components.url!)
        return components.url
    }
}
