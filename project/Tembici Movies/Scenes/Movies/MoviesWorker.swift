//
//  MoviesWorker.swift
//  Tembici Movies
//
//  Created by Guilherme Baldissera on 12/05/20.
//  Copyright © 2020 Guilherme Baldissera. All rights reserved.
//

import UIKit

// MARK: - Movies Worker Class

class MoviesWorker {

    func getMovies(page: Int, completion: @escaping (Result<MovieList, NetworkError>, _ fromCache: Bool) -> Void) {
        let endpoint = MovieEndpoint.getPopularMovies(page: page)
        NetworkManager().request(
            endpoint: endpoint,
            withDecodeType: MovieList.self,
            completion: completion)
    }
}
