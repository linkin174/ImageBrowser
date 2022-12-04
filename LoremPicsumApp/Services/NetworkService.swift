//
//  NetworkService.swift
//  LoremPicsumApp
//
//  Created by Aleksandr Kretov on 13.11.2022.
//

import Foundation

enum NetworkingError: Error {
    case badURL
    case noResponse
    case badResponse
    case noData
}

extension NetworkingError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .badURL:
            return NSLocalizedString("Bad url for request", comment: "badURL")
        case .noResponse:
            return NSLocalizedString("Server is not responding", comment: "noResponse")
        case .badResponse:
            return NSLocalizedString("Bad response code", comment: "badResponse")
        case .noData:
            return NSLocalizedString("No data returned from server", comment: "noData")
        }
    }
}

protocol NetworkingProtocol {
    func makeRequest(_ method: String, _ parameters: [String: String]?) async throws -> Data
}

final class NetworkService: NetworkingProtocol {

    func makeRequest(_ method: String, _ parameters: [String: String]? = nil) async throws -> Data {
        guard let url = createURL(method, parameters) else { throw NetworkingError.badURL }
        var request = URLRequest(url: url)
        request.timeoutInterval = 10
        request.cachePolicy = .reloadRevalidatingCacheData
        let result: (data: Data, response: URLResponse)? = try? await URLSession.shared.data(for: request)
        guard let response = result?.response as? HTTPURLResponse else { throw NetworkingError.noResponse }
        guard 200 ... 299 ~= response.statusCode else { throw NetworkingError.badResponse }
        guard let data = result?.data else { throw NetworkingError.noData }
        return data
    }

//    func makeRequestWithCompletion(_ method: String, _ parameters: [String: String]? = nil, completion: @escaping (Result<Data, Error>) -> Void) {
//        var dataTask: URLSessionDataTask?
//        var observation: NSKeyValueObservation?
//        guard let url = createURL(method, parameters) else {
//            completion(.failure(APIError.badURL))
//            return
//        }
//        dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
//            observation?.invalidate()
//            if let error {
//                completion(.failure(error))
//            }
//            guard let response = response as? HTTPURLResponse else {
//                completion(.failure(APIError.noResponse))
//                return
//            }
//            guard 200...299 ~= response.statusCode else {
//                completion(.failure(APIError.badResponse))
//                return
//            }
//            guard let data else {
//                completion(.failure(APIError.noData))
//                return
//            }
//            completion(.success(data))
//        }
//        dataTask?.resume()
//        observation = dataTask?.progress.observe(\.fractionCompleted) { observationProgress, _ in
//            DispatchQueue.main.async { [weak self] in
//                self?.downloadProgress = observationProgress.fractionCompleted
//            }
//        }
//    }

    fileprivate func createURL(_ method: String, _ parameters: [String: String]?) -> URL? {
        var components = URLComponents()
        components.scheme = MainAPI.scheme
        components.host = MainAPI.host
        components.path = method
        if let parameters {
            components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
        }
        return components.url
    }
}
