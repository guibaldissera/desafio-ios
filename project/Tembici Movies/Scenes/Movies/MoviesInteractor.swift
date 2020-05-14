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
    private var loadingPage: Bool = false

    // MARK: Private Methods

    private func handleMovies(result: Result<MovieList, NetworkError>, reloadedData: Bool) {
        // Create variable of response
        let response: Movies.GetMovies.Response

        switch result {
        case let .success(movieList):
            // TODO: Adjust data when received from cache and reloaded from server

            // Update properties
            movies.append(contentsOf: movieList.movies)
            totalPages = movieList.totalPages

            // Create response model
            let lastPage = actualPage == totalPages
            response = Movies.GetMovies.Response(movies: movies, lastPage: lastPage)

        case let .failure(error):
            // Create response model
            response = Movies.GetMovies.Response(movies: movies, lastPage: false, error: error)
            actualPage -= 1
        }

        loadingPage.toggle()
        // Call presenter with response
        presenter?.presentMovies(response: response)
    }
}

// MARK: - Movies Interactor Extension with BusinessLogic

extension MoviesInteractor: MoviesBusinessLogic {

    func getMovies(request: Movies.GetMovies.Request) {
        guard !loadingPage else { return }

        // Reset properties
        if request.resetItens {
            actualPage = 0
            movies = []
        }

        // Update actual page
        actualPage += 1

        // Request data
        loadingPage.toggle()
        worker = MoviesWorker()
        worker?.getMovies(page: actualPage, completion: handleMovies)
    }
}
