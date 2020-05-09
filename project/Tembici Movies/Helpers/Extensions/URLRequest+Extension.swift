//
//  URLRequest+Extension.swift
//  Tembici Movies
//
//  Created by Guilherme Baldissera on 09/05/20.
//  Copyright © 2020 Guilherme Baldissera. All rights reserved.
//

import Foundation

extension URLRequest {

    /// URLRequest constructor using NetworkEndpoint
    /// - Parameter endpoint: endpoint data
    init(with endpoint: NetworkEndpoint) {
        // Create URL based on endpoint full url
        self.init(url: endpoint.fullURL)

        // Add method
        self.httpMethod = endpoint.method.rawValue

        // Add body params
        if let params = endpoint.bodyParams {
            self.httpBody = try? JSONSerialization.data(withJSONObject: params)
        }

        // Add headers
        endpoint.headers?.forEach { key, value in
            self.addValue(value, forHTTPHeaderField: key)
        }
    }
}
