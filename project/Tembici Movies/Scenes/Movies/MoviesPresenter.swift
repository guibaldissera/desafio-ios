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

    // MARK: Private Methods

    private func formatMovies(_ movies: [Movie]) -> [SimpleMovie] {
        let formattedMovies: [SimpleMovie] = movies.map { movie -> SimpleMovie in
            let simpleMovie = SimpleMovie(
                identifier: movie.identfier,
                image: UIImage(),
                name: movie.title,
                favorited: false)
            return simpleMovie
        }
        return formattedMovies
    }
}

// MARK: - Movies Presenter Extension with PresentationLogic

extension MoviesPresenter: MoviesPresentationLogic {

    func presentMovies(response: Movies.GetMovies.Response) {

        // Validate response to present on view
        if response.error != nil {
            if case NetworkError.sessionUnavailble = response.error! {
                viewController?.displayNoInternet()
            } else {
                let errorMessage = NSLocalizedString("Erro na lista de filmes", comment: "Movie list error (Friendly)")
                viewController?.displayError(message: errorMessage)
            }
        } else {
            let viewModel = Movies.GetMovies.ViewModel(movies: formatMovies(response.newMovies))
            viewController?.displayMovies(viewModel: viewModel)
        }
    }
}
