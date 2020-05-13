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
    func presentSomething(response: MovieDetail.Something.Response)
}

// MARK: - MovieDetail Presenter Class

class MovieDetailPresenter {

    // MARK: Scene Properties
    weak var viewController: MovieDetailDisplayLogic?
}

// MARK: - MovieDetail Presenter Extension with PresentationLogic

extension MovieDetailPresenter: MovieDetailPresentationLogic {

    func presentSomething(response: MovieDetail.Something.Response) {
        let viewModel = MovieDetail.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
