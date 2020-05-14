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

    private func calculateIndexPathsToReload(from totalCount: Int, newCount: Int) -> [IndexPath] {
        let startIndex = totalCount - newCount
        let endIndex = startIndex + newCount
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
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
            let noMoreMoviesTitle = NSLocalizedString(
                "Sem mais filmes",
                comment: "No more movies to get")
            let chargeMoreMoviesTitle = NSLocalizedString(
                "Carregando mais filmes",
                comment: "Pagination footer for searching more movies")
            let footerTitle = response.lastPage ? noMoreMoviesTitle : chargeMoreMoviesTitle

            // Create view model based on calculated itens
            let viewModel = Movies.GetMovies.ViewModel(movies: formatMovies(response.movies), movieFooter: footerTitle)
            viewController?.displayMovies(viewModel: viewModel)
        }
    }
}
