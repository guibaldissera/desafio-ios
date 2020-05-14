//
//  MovieDetailInteractor.swift
//  Tembici Movies
//
//  Created by Guilherme Baldissera on 12/05/20.
//  Copyright © 2020 Guilherme Baldissera. All rights reserved.
//

import UIKit

// MARK: - MovieDetail BusinessLogic Protocol

protocol MovieDetailBusinessLogic {
    func getMovie(request: MovieDetail.GetMovie.Request)
}

// MARK: - MovieDetail DataStore Protocol

protocol MovieDetailDataStore {
    var movie: Movie? { get set }
}

// MARK: - MovieDetail Interactor Class with DataStore

class MovieDetailInteractor: MovieDetailDataStore {

    // MARK: Scene Properties
    var presenter: MovieDetailPresentationLogic?
    var worker: MovieDetailWorker?

    // MARK: DataStore Properties
    var movie: Movie?
}

// MARK: - MovieDetail Interactor Extension with BusinessLogic

extension MovieDetailInteractor: MovieDetailBusinessLogic {

    func getMovie(request: MovieDetail.GetMovie.Request) {
        let response = MovieDetail.GetMovie.Response(movie: movie)
        presenter?.presentMovie(response: response)
    }
}
