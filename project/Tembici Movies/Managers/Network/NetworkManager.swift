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
    typealias NetworkDefaultResult<T> = Result<T, NetworkError>
    typealias RequestResult<T> = (NetworkDefaultResult<T>) -> Void

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

    // MARK: - Private Methods

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

        // Get completion result based on status code
        let completionResult: NetworkDefaultResult<T>

        // Validate response
        switch response.statusCode {
        case 200...299:
            if let data = data {
                completionResult = self.decodeData(data)
            } else {
                completionResult = .failure(.emptyData)
            }
        case 401:
            completionResult = .failure(.apiUnauthorized)
        case 404:
            completionResult = .failure(.apiPathNotFound)
        case 500:
            completionResult = .failure(.apiError)
        default:
            completionResult = .failure(.unexpected)
        }

        // Send result
        completion(completionResult)
    }

    /// Method to decode data trwoing the error
    /// - Parameter data: data to decode
    private func decodeData<T>(_ data: Data) -> NetworkDefaultResult<T> where T: Decodable {

        // Variable to auxiliar completion
        let decodeResult: NetworkDefaultResult<T>

        // Try to decode model
        do {
            let model = try JSONDecoder().decode(T.self, from: data)
            decodeResult = .success(model)

        // Throw specific decoding error
        } catch let decodeError as DecodingError {
            switch decodeError {
            case let .keyNotFound(codingKey, _):
                let message = "Key not Found: \(codingKey.stringValue)"
                decodeResult = .failure(.decoderFailed(message: message))
            default:
                let message = decodeError.localizedDescription
                decodeResult = .failure(.decoderFailed(message: message))
            }

        // Throw any other error
        } catch let otherError {
            let message = otherError.localizedDescription
            decodeResult = .failure(.decoderFailed(message: message))
        }
        return decodeResult
    }
}
