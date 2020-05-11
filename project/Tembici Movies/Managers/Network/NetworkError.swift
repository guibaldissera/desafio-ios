//
//  NetworkError.swift
//  Tembici Movies
//
//  Created by Guilherme Baldissera on 09/05/20.
//  Copyright © 2020 Guilherme Baldissera. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    // API errors
    case apiUnauthorized
    case apiPathNotFound
    case apiError

    // Data errors
    case emptyResponse
    case emptyData
    case decoderFailed(message: String)

    // Default errors
    case sessionUnavailble
    case unexpected
}
