//
//  MoviesInteractor.swift
//  Tembici Movies
//
//  Created by Guilherme Baldissera on 12/05/20.
//  Copyright © 2020 Guilherme Baldissera. All rights reserved.
//

import UIKit

// MARK: - Movies BusinessLogic Protocol

protocol MoviesBusinessLogic {
    func getMovies(request: Movies.GetMovies.Request)
    func getNextMovies(request: Movies.GetMovies.Request)
}

// MARK: - Movies DataStore Protocol

protocol MoviesDataStore {
    var actualPage: Int { get set }
    var movies: [Movie] { get set }
}

// MARK: - Movies Interactor Class with DataStore

class MoviesInteractor: MoviesDataStore {

    // MARK: Scene Properties
    var presenter: MoviesPresentationLogic?
    var worker: MoviesWorker?

    // MARK: DataStore Properties
    var actualPage: Int = 0
    var movies: [Movie] = []

    // MARK: Other Properties
    private var totalPages: Int = 0
    private var totalMovies: Int = 0

    // MARK: Private Methods

    private func handleMovies(result: Result<MovieList, NetworkError>, fromCache: Bool) {
        // Create variable of response
        let response: Movies.GetMovies.Response

        switch result {
        case let .success(movieList):
            // Update properties
            movies.append(contentsOf: movieList.movies)
            totalPages = movieList.totalPages
            totalMovies = movieList.totalMovies
            actualPage = movieList.page

            // Create response model
            response = Movies.GetMovies.Response(movies: movies, fromCache: fromCache)

        case let .failure(error):
            // Update properties
            actualPage -= 1

            // Create response model
            response = Movies.GetMovies.Response(movies: [], fromCache: fromCache, error: error)
        }

        // Call presenter with response
        presenter?.presentMovies(response: response)
    }
}

// MARK: - Movies Interactor Extension with BusinessLogic

extension MoviesInteractor: MoviesBusinessLogic {

    func getMovies(request: Movies.GetMovies.Request) {
        // Reset properties
        actualPage = 1
        movies = []

        // Request data
        worker = MoviesWorker()
        worker?.getMovies(page: actualPage, completion: handleMovies)
    }

    func getNextMovies(request: Movies.GetMovies.Request) {
        // Update properties
        actualPage += 1
        worker = MoviesWorker()
        worker?.getMovies(page: actualPage, completion: handleMovies)
    }
}
