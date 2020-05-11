//
//  Movie.swift
//  Tembici Movies
//
//  Created by Guilherme Baldissera on 11/05/20.
//  Copyright © 2020 Guilherme Baldissera. All rights reserved.
//

import Foundation

struct Movie: Decodable {

    // MARK: Properties
    var identfier: Int
    var title: String
    var genres: [Int]
    var posterPath: String

    // MARK: Coding Keys
    enum CodingKeys: String, CodingKey {
        case identfier = "id"
        case title
        case genres = "genre_ids"
        case posterPath = "poster_path"
    }
}
