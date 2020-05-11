//
//  NetworkManager.swift
//  Tembici Movies
//
//  Created by Guilherme Baldissera on 09/05/20.
//  Copyright © 2020 Guilherme Baldissera. All rights reserved.
//

import Foundation

class NetworkManager {

    // MARK: - TypeAlias
    typealias RequestResult<T> = (Result<T, NetworkError>) -> Void

    // MARK: - Properties
    private var session: URLSession

    // MARK: - Constructors
    /// Constructor to create new network with especific session or with default shared session
    /// - Parameter session: session for requests
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    // MARK: - Methods

    /// Request method to get response in String format
    /// - Parameters:
    ///   - endpoint: data to do request
    ///   - completion: completion to receive response for request
    func request(endpoint: NetworkEndpoint, completion: @escaping RequestResult<String>) {
        self.request(endpoint: endpoint, withDecodeType: String.self, completion: completion)
    }

    /// Request method to get response in format based on decode type
    /// - Parameters:
    ///   - endpoint: data to do request
    ///   - withDecodeType: type to decode response
    ///   - completion: completion to receive response for request
    func request<T>(endpoint: NetworkEndpoint, withDecodeType: T.Type, completion: @escaping RequestResult<T>) where T: Decodable {

        // Create url request based in endpoint
        let request = URLRequest(with: endpoint)

        // Create new data task
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            self.handleTask(data: data, response: response, error: error, completion: completion)
        })
        task.resume()
    }

    /// Method to handle response of session task
    /// - Parameters:
    ///   - data: data received
    ///   - response: response received
    ///   - error: error received if exist
    ///   - completion: completion to resolve when task handled
    private func handleTask<T>(data: Data?, response: URLResponse?, error: Error?, completion: @escaping RequestResult<T>) where T: Decodable {
        // Received an error unexpected
        guard error == nil else {
            completion(.failure(.unexpected))
            return
        }
        // Received a unexpected or empty response
        guard let response = response as? HTTPURLResponse else {
            completion(.failure(.emptyResponse))
            return
        }

        switch response.statusCode {
        case 200...299:
            if let data = data {
                if let model = try? JSONDecoder().decode(T.self, from: data) {
                    completion(.success(model))
                } else {
                    completion(.failure(.decoderFailed))
                }
            } else {
                completion(.failure(.emptyData))
            }
        case 401:
            completion(.failure(.apiUnauthorized))
        case 404:
            completion(.failure(.apiPathNotFound))
        case 500:
            completion(.failure(.apiError))
        default:
            completion(.failure(.unexpected))
        }
    }
}
