//
//  MoviesRouter.swift
//  Tembici Movies
//
//  Created by Guilherme Baldissera on 12/05/20.
//  Copyright © 2020 Guilherme Baldissera. All rights reserved.
//

import UIKit

// MARK: - Movies RoutingLogic Protocol

@objc protocol MoviesRoutingLogic {
    func routeToMovieDetail()
}

// MARK: - Movies DataPassing Protocol

protocol MoviesDataPassing {
    var dataStore: MoviesDataStore? { get }
}

// MARK: - Movies Router Class with DataPassing

class MoviesRouter: NSObject, MoviesDataPassing {

    // MARK: Scene Properties
    weak var viewController: MoviesViewController?

    // MARK: DataPassing Properties
    var dataStore: MoviesDataStore?
}

// MARK: - Movies Router Extension with RoutingLogic

extension MoviesRouter: MoviesRoutingLogic {

    // MARK: Routing

     func routeToMovieDetail() {
         let destinationVC = MovieDetailViewController()
         var destinationDS = destinationVC.router!.dataStore!
         passDataToSomewhere(source: dataStore!, destination: &destinationDS)
         navigateToSomewhere(source: viewController!, destination: destinationVC)
     }

    // MARK: Navigation

    func navigateToSomewhere(source: MoviesViewController, destination: MovieDetailViewController) {
        source.show(destination, sender: nil)
     }

    // MARK: Passing data

     func passDataToSomewhere(source: MoviesDataStore, destination: inout MovieDetailDataStore) {
        if let selectedMovie = viewController?.tableView?.indexPathForSelectedRow?.row {
            destination.movie = source.movies[selectedMovie]
        }
    }
}
