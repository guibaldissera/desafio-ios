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
        struct Request {
            var resetItens: Bool = false
        }

        struct Response {
            var movies: [Movie]
            var lastPage: Bool
            var error: NetworkError?
        }

        struct ViewModel {
            var movies: [SimpleMovie]
            var movieFooter: String?
        }
    }
}

struct SimpleMovie {
    let identifier: Int
    let image: UIImage
    let name: String
    let favorited: Bool
}
