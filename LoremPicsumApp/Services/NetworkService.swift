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
    case badResponse = "Bad response code"
    case noData = "Server not returned data"
    case badDecoding = "Data decoding error"
}

protocol NetworkingProtocol {
    func makeRequest(_ method: String, _ parameters: [String: String]?) async throws -> Data
    func makeRequestWithCompletion(_ method: String, _ parameters: [String: String]?, completion: @escaping (Result<Data, Error>) -> Void)
    var progressPublisher: Published<Double>.Publisher { get }
}

final class NetworkService: NetworkingProtocol {

    @Published private var downloadProgress: Double = 0

    var progressPublisher: Published<Double>.Publisher { self.$downloadProgress }

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
        } catch {
            throw error
        }
    }

    func makeRequestWithCompletion(_ method: String, _ parameters: [String: String]? = nil, completion: @escaping (Result<Data, Error>) -> Void) {
        var dataTask: URLSessionDataTask?
        var observation: NSKeyValueObservation?
        guard let url = createURL(method, parameters) else {
            completion(.failure(APIError.badURL))
            return
        }
        dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            observation?.invalidate()
            if let error {
                completion(.failure(error))
            }
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(APIError.noResponse))
                return
            }
            guard 200...299 ~= response.statusCode else {
                completion(.failure(APIError.badResponse))
                return
            }
            guard let data else {
                completion(.failure(APIError.noData))
                return
            }
            completion(.success(data))
        }
        dataTask?.resume()
        observation = dataTask?.progress.observe(\.fractionCompleted) { observationProgress, _ in
            DispatchQueue.main.async { [weak self] in
                self?.downloadProgress = observationProgress.fractionCompleted
            }
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
        return components.url
    }
}
