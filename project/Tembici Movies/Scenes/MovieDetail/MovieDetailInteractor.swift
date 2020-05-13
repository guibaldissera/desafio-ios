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
    func doSomething(request: MovieDetail.Something.Request)
}

// MARK: - MovieDetail DataStore Protocol

protocol MovieDetailDataStore {}

// MARK: - MovieDetail Interactor Class with DataStore

class MovieDetailInteractor: MovieDetailDataStore {

    // MARK: Scene Properties
    var presenter: MovieDetailPresentationLogic?
    var worker: MovieDetailWorker?

    // MARK: DataStore Properties
}

// MARK: - MovieDetail Interactor Extension with BusinessLogic

extension MovieDetailInteractor: MovieDetailBusinessLogic {

    func doSomething(request: MovieDetail.Something.Request) {
        worker = MovieDetailWorker()
        worker?.doSomeWork()

        let response = MovieDetail.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
