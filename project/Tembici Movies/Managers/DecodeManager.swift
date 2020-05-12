//
//  DecodeManager.swift
//  Tembici Movies
//
//  Created by Guilherme Baldissera on 12/05/20.
//  Copyright © 2020 Guilherme Baldissera. All rights reserved.
//

import Foundation

class DecodeManager {

    /// Auxiliar method to decode data without validations
    /// - Parameter data: data to decode
    static func decodeData<T: Decodable>(_ data: Data) -> T? {
        let model = try? JSONDecoder().decode(T.self, from: data)
        return model
    }

    /// Method to decode data throwing the error
    /// - Parameter data: data to decode
    static func tryToDecodeData<T: Decodable>(_ data: Data) -> Result<T, NetworkError> {

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
