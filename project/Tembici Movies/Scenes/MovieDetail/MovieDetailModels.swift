//
//  MovieDetailModels.swift
//  Tembici Movies
//
//  Created by Guilherme Baldissera on 12/05/20.
//  Copyright © 2020 Guilherme Baldissera. All rights reserved.
//

import UIKit

// MARK: - MovieDetail Enums

enum MovieDetail {

    enum GetMovie {
        struct Request {}
        struct Response {
            var movie: Movie?
        }
        struct ViewModel {
            var movie: SimpleMovie
        }
    }

    enum GetCompleteMovie {
        struct Request {}
        struct Response {}
        struct ViewModel {}
    }
}
