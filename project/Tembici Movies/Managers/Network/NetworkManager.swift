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
    typealias RequestResult<T> = (_ result: Result<T, NetworkError>, _ fromCache: Bool) -> Void

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
    func request<T: Decodable>(endpoint: NetworkEndpoint, withDecodeType: T.Type, completion: @escaping RequestResult<T>) {

        // Create url request based in endpoint
        let request = URLRequest(with: endpoint)

        // Create cache manager
        let cache = CacheManager(for: request)

        // Get from cache
        if let dataFromCache = cache.getCache(), let decodedData: T = self.decodeData(dataFromCache) {
            completion(.success(decodedData), true)
        }

        // Create new data task
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in

            // Handle the task received from request
            let handledTask = self.handleTask(data: data, response: response, error: error)

            // Validate if the task is handled
            switch handledTask {
            case let .failure(handledError):
                completion(.failure(handledError), false)

            case let .success(handledData):
                // Decode data received from task
                let resultDecoder: Result<T, NetworkError> = self.tryToDecodeData(handledData)

                // Validate if the data is decoded
                switch resultDecoder {
                case let .success(decodedData):

                    if !cache.isEqual(data: handledData) {
                        cache.updateCache(data: handledData, response: response)
                        completion(.success(decodedData), false)
                    } else {
                        // Nothing to do
                        // If received data is equal data from cache,
                        // the data is already up to date,
                        // don't need to refresh screen
                    }

                case let .failure(decodedError):
                    completion(.failure(decodedError), false)
                }
            }
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
    private func handleTask(data: Data?, response: URLResponse?, error: Error?) -> Result<Data, NetworkError> {

        // Received an error unexpected
        guard error == nil else {
            return .failure(.unexpected)
        }
        // Received a unexpected or empty response
        guard let response = response as? HTTPURLResponse else {
            return .failure(.emptyResponse)
        }

        // Get completion result based on status code
        let errorResult: NetworkError

        // Validate response
        switch response.statusCode {
        case 200...299:
            if let data = data {
                return .success(data)
            } else {
                errorResult = .emptyData
            }
        case 401:
            errorResult = .apiUnauthorized
        case 404:
            errorResult = .apiPathNotFound
        case 500:
            errorResult = .apiError
        default:
            errorResult = .unexpected
        }
        return .failure(errorResult)
    }

    /// Auxiliar method to decod data without validations
    /// - Parameter data: data to decode
    private func decodeData<T: Decodable>(_ data: Data) -> T? {
        let model = try? JSONDecoder().decode(T.self, from: data)
        return model
    }

    /// Method to decode data throwing the error
    /// - Parameter data: data to decode
    private func tryToDecodeData<T: Decodable>(_ data: Data) -> Result<T, NetworkError> {

        // Variable to auxiliar completion
        let decodeResult: Result<T, NetworkError>

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
