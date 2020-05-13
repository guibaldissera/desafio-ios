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
    func doSomething(request: Movies.Something.Request)
}

// MARK: - Movies DataStore Protocol

protocol MoviesDataStore {}

// MARK: - Movies Interactor Class with DataStore

class MoviesInteractor: MoviesDataStore {

    // MARK: Scene Properties
    var presenter: MoviesPresentationLogic?
    var worker: MoviesWorker?

    // MARK: DataStore Properties
}

// MARK: - Movies Interactor Extension with BusinessLogic

extension MoviesInteractor: MoviesBusinessLogic {

    func doSomething(request: Movies.Something.Request) {
        worker = MoviesWorker()
        worker?.doSomeWork()

        let response = Movies.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
