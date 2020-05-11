//
//  MovieList.swift
//  Tembici Movies
//
//  Created by Guilherme Baldissera on 11/05/20.
//  Copyright © 2020 Guilherme Baldissera. All rights reserved.
//

import Foundation

struct MovieList: Decodable {

    // MARK: Properties
    var page: Int
    var totalMovies: Int
    var totalPages: Int
    var movies: [Movie]

    // MARK: Coding Keys
    enum CodingKeys: String, CodingKey {
        case page
        case totalMovies = "total_results"
        case totalPages = "total_pages"
        case movies = "results"
    }
}
