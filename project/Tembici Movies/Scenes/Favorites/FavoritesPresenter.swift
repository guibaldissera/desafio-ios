//
//  FavoritesPresenter.swift
//  Tembici Movies
//
//  Created by Guilherme Baldissera on 12/05/20.
//  Copyright © 2020 Guilherme Baldissera. All rights reserved.
//

import UIKit

// MARK: - Favorites PresentationLogic Protocol

protocol FavoritesPresentationLogic {
    func presentSomething(response: Favorites.Something.Response)
}

// MARK: - Favorites Presenter Class

class FavoritesPresenter {

    // MARK: Scene Properties
    weak var viewController: FavoritesDisplayLogic?
}

// MARK: - Favorites Presenter Extension with PresentationLogic

extension FavoritesPresenter: FavoritesPresentationLogic {

    func presentSomething(response: Favorites.Something.Response) {
        let viewModel = Favorites.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
