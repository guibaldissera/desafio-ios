//
//  MovieDetailPresenter.swift
//  Tembici Movies
//
//  Created by Guilherme Baldissera on 12/05/20.
//  Copyright © 2020 Guilherme Baldissera. All rights reserved.
//

import UIKit

// MARK: - MovieDetail PresentationLogic Protocol

protocol MovieDetailPresentationLogic {
    func presentMovie(response: MovieDetail.GetMovie.Response)
    func presentCompleteMovie(response: MovieDetail.GetCompleteMovie.Response)
}

// MARK: - MovieDetail Presenter Class

class MovieDetailPresenter {

    // MARK: Scene Properties
    weak var viewController: MovieDetailDisplayLogic?
}

// MARK: - MovieDetail Presenter Extension with PresentationLogic

extension MovieDetailPresenter: MovieDetailPresentationLogic {

    func presentMovie(response: MovieDetail.GetMovie.Response) {
        if let movie = response.movie {
            let simpleMovie = SimpleMovie(
                identifier: movie.identfier,
                image: UIImage(),
                name: movie.title,
                favorited: false)
            let viewModel = MovieDetail.GetMovie.ViewModel(movie: simpleMovie)
            viewController?.displayMovie(viewModel: viewModel)
        } else {
            // Show problem
        }
    }

    func presentCompleteMovie(response: MovieDetail.GetCompleteMovie.Response) {

    }
}
