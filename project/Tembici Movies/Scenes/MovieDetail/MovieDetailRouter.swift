//
//  MovieDetailRouter.swift
//  Tembici Movies
//
//  Created by Guilherme Baldissera on 12/05/20.
//  Copyright © 2020 Guilherme Baldissera. All rights reserved.
//

import UIKit

// MARK: - MovieDetail RoutingLogic Protocol

@objc protocol MovieDetailRoutingLogic {
    // func routeToSomewhere()
}

// MARK: - MovieDetail DataPassing Protocol

protocol MovieDetailDataPassing {
    var dataStore: MovieDetailDataStore? { get }
}

// MARK: - MovieDetail Router Class with DataPassing

class MovieDetailRouter: NSObject, MovieDetailDataPassing {

    // MARK: Scene Properties
    weak var viewController: MovieDetailViewController?

    // MARK: DataPassing Properties
    var dataStore: MovieDetailDataStore?
}

// MARK: - MovieDetail Router Extension with RoutingLogic

extension MovieDetailRouter: MovieDetailRoutingLogic {

    // MARK: Routing

    // func routeToSomewhere() {
    //     let destinationVC = SomewhereViewController()
    //     var destinationDS = destinationVC.router!.dataStore!
    //     passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //     navigateToSomewhere(source: viewController!, destination: destinationVC)
    // }

    // MARK: Navigation

    // func navigateToSomewhere(source: MovieDetailViewController, destination: SomewhereViewController) {
    //     source.show(destination, sender: nil)
    // }

    // MARK: Passing data

    // func passDataToSomewhere(source: MovieDetailDataStore, destination: inout SomewhereDataStore) {
    //     destination.name = source.name
    // }
}
