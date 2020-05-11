//
//  MovieEndpoint.swift
//  Tembici Movies
//
//  Created by Guilherme Baldissera on 09/05/20.
//  Copyright © 2020 Guilherme Baldissera. All rights reserved.
//

import Foundation

enum MovieEndpoint {
    case getPopularMovies(page: Int)
}

extension MovieEndpoint: NetworkEndpoint {

    var path: String {
        switch self {
        case .getPopularMovies:
            return "/movie/popular"
        }
    }

    var method: NetworkMethod { return .get }

    var bodyParams: Parameters? { return nil }

    var queryParams: Parameters? {
        switch self {
        case let .getPopularMovies(page):
            return ["page": page]
        }
    }

    var headers: Headers? { return nil }
}
