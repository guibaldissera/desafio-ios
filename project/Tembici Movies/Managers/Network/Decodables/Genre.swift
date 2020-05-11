//
//  Genre.swift
//  Tembici Movies
//
//  Created by Guilherme Baldissera on 11/05/20.
//  Copyright © 2020 Guilherme Baldissera. All rights reserved.
//

import Foundation

struct Genre: Decodable {

    // MARK: Properties
    var identfier: Int
    var name: String

    // MARK: Coding Keys
    enum CodingKeys: String, CodingKey {
        case identfier = "id"
        case name
    }
}
