//
//  FavoritesInteractor.swift
//  Tembici Movies
//
//  Created by Guilherme Baldissera on 12/05/20.
//  Copyright © 2020 Guilherme Baldissera. All rights reserved.
//

import UIKit

// MARK: - Favorites BusinessLogic Protocol

protocol FavoritesBusinessLogic {
    func doSomething(request: Favorites.Something.Request)
}

// MARK: - Favorites DataStore Protocol

protocol FavoritesDataStore {}

// MARK: - Favorites Interactor Class with DataStore

class FavoritesInteractor: FavoritesDataStore {

    // MARK: Scene Properties
    var presenter: FavoritesPresentationLogic?
    var worker: FavoritesWorker?

    // MARK: DataStore Properties
}

// MARK: - Favorites Interactor Extension with BusinessLogic

extension FavoritesInteractor: FavoritesBusinessLogic {

    func doSomething(request: Favorites.Something.Request) {
        worker = FavoritesWorker()
        worker?.doSomeWork()

        let response = Favorites.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
