//
//  MoviesPresenter.swift
//  Tembici Movies
//
//  Created by Guilherme Baldissera on 12/05/20.
//  Copyright © 2020 Guilherme Baldissera. All rights reserved.
//

import UIKit

// MARK: - Movies PresentationLogic Protocol

protocol MoviesPresentationLogic {
    func presentMovies(response: Movies.GetMovies.Response)
}

// MARK: - Movies Presenter Class

class MoviesPresenter {

    // MARK: Scene Properties
    weak var viewController: MoviesDisplayLogic?
}

// MARK: - Movies Presenter Extension with PresentationLogic

extension MoviesPresenter: MoviesPresentationLogic {

    func presentMovies(response: Movies.GetMovies.Response) {
        let viewModel = Movies.GetMovies.ViewModel()
        viewController?.displayMovies(viewModel: viewModel)
    }
}
