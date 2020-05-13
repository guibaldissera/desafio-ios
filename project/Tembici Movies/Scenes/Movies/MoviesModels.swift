//
//  MoviesModels.swift
//  Tembici Movies
//
//  Created by Guilherme Baldissera on 12/05/20.
//  Copyright © 2020 Guilherme Baldissera. All rights reserved.
//

import UIKit

// MARK: - Movies Enums

enum Movies {

    enum GetMovies {
        struct Request {}

        struct Response {
            var newMovies: [Movie]
            var fromCache: Bool
            var error: NetworkError?
        }

        struct ViewModel {
            var movies: [SimpleMovie]
        }
    }
}

struct SimpleMovie {
    let identifier: Int
    let image: UIImage
    let name: String
    let favorited: Bool
}
