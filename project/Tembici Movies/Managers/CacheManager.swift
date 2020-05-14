//
//  CacheManager.swift
//  Tembici Movies
//
//  Created by Guilherme Baldissera on 12/05/20.
//  Copyright © 2020 Guilherme Baldissera. All rights reserved.
//

import Foundation

class CacheManager {

    // MARK: Properties

    private let request: URLRequest

    // MARK: Constructors

    /// Method to construct cache manager for one specific request task
    /// - Parameter request: request to identify cache
    init(for request: URLRequest) {
        self.request = request
    }

    // MARK: Control Methods

    /// Get actual cache from request, if exist
    func getCache() -> Data? {
        return URLCache.shared.cachedResponse(for: request)?.data
    }

    /// Update cache with new response and data received from task
    /// - Parameters:
    ///   - data: data to cache
    ///   - response: object to identify properties of response and find cache
    func updateCache(data: Data, response: URLResponse?) {
        guard let response = response else { return }

        // Save cache updating or inserting
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: request)
    }

    /// Validate if actual cache is the same that data in attribute
    /// - Parameter data: data to compare with actual cache
    func isEqual(data: Data) -> Bool {
        let cached = self.getCache()
        return cached != nil && cached == data
    }

    /// Clean actual cache of this request
    func removeCache() {
        URLCache.shared.removeCachedResponse(for: request)
    }

    // MARK: - Static Methods

    /// Function to clear all cache storaged
    static func removeAllCache() {
        URLCache.shared.removeAllCachedResponses()
    }
}
