//
//  NetworkEndpoint.swift
//  Tembici Movies
//
//  Created by Guilherme Baldissera on 09/05/20.
//  Copyright © 2020 Guilherme Baldissera. All rights reserved.
//

import Foundation

// MARK: - Auxiliars

typealias Headers = [String: String]
typealias Parameters = [String: Any]

enum NetworkMethod: String {
    case get = "GET"
    case post = "POST"
}

// MARK: - NetworkEndpoint Protocol

protocol NetworkEndpoint {

    // MARK: Default properties

    var path: String { get }
    var method: NetworkMethod { get }
    var bodyParams: Parameters? { get }
    var queryParams: Parameters? { get }
    var headers: Headers? { get }
}

// MARK: - NetworkEndpoint Protocol Extension

extension NetworkEndpoint {

    // MARK: Extended Properties

    /// Property for help to create complete url.
    var fullURL: URL {
        // Concat base url with endpoint path
        let url = Config.ServerURL.appendingPathComponent(self.path)

        // Valida params
        if let queryParams = self.queryParams {
            return self.addQueryParamsAt(url: url, params: queryParams)
        } else {
            return url
        }
    }

    /// Property to get headers with default data
    var fullHeaders: Headers {
        if let headers = self.headers {
            // If exist setted headers, need to add default headers
            var auxiliarHeader = headers
            for item in defaultHeaders {
                auxiliarHeader[item.key] = item.value
            }
            return auxiliarHeader
        } else {
            // Otherwise, only send default headers
            return defaultHeaders
        }
    }

    // MARK: Private Extended Properties

    private var defaultHeaders: Headers {
        return [
            "Authorization": "Bearer \(Config.ServerToken)",
            "Content-Type": "application/json;charset=utf-8"
        ]
    }

    // MARK: Private Methods

    /// Add query params in URL
    /// - Parameters:
    ///   - url: url to add params
    ///   - params: params to add
    private func addQueryParamsAt(url: URL, params: Parameters) -> URL {

        // Create component to add itens on url
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!

        // Mapping query params
        components.queryItems = params.map { (key, value) in
            return URLQueryItem(name: key, value: String(describing: value))
        }

        // If components url not exist, return default url
        return components.url ?? url
    }
}
