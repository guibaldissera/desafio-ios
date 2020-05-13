//
//  FavoritesRouter.swift
//  Tembici Movies
//
//  Created by Guilherme Baldissera on 12/05/20.
//  Copyright © 2020 Guilherme Baldissera. All rights reserved.
//

import UIKit

// MARK: - Favorites RoutingLogic Protocol

@objc protocol FavoritesRoutingLogic {
    // func routeToSomewhere()
}

// MARK: - Favorites DataPassing Protocol

protocol FavoritesDataPassing {
    var dataStore: FavoritesDataStore? { get }
}

// MARK: - Favorites Router Class with DataPassing

class FavoritesRouter: NSObject, FavoritesDataPassing {

    // MARK: Scene Properties
    weak var viewController: FavoritesViewController?

    // MARK: DataPassing Properties
    var dataStore: FavoritesDataStore?
}

// MARK: - Favorites Router Extension with RoutingLogic

extension FavoritesRouter: FavoritesRoutingLogic {

    // MARK: Routing

    // func routeToSomewhere() {
    //     let destinationVC = SomewhereViewController()
    //     var destinationDS = destinationVC.router!.dataStore!
    //     passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //     navigateToSomewhere(source: viewController!, destination: destinationVC)
    // }

    // MARK: Navigation

    // func navigateToSomewhere(source: FavoritesViewController, destination: SomewhereViewController) {
    //     source.show(destination, sender: nil)
    // }

    // MARK: Passing data

    // func passDataToSomewhere(source: FavoritesDataStore, destination: inout SomewhereDataStore) {
    //     destination.name = source.name
    // }
}
