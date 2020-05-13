//
//  RootTabBarController.swift
//  Tembici Movies
//
//  Created by Guilherme Baldissera on 08/05/20.
//  Copyright © 2020 Guilherme Baldissera. All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create MoviesViewController
        let moviesImage = UIImage.init(named: "icon-tabbar-movies")
        let moviesViewController = MoviesViewController()
        moviesViewController.tabBarItem = UITabBarItem(title: "Filmes", image: moviesImage, tag: 0)

        // Create FavoriteViewController
        let favoritesImage = UIImage(named: "icon-tabbar-favorites")
        let favoritesViewController = FavoritesViewController()
        favoritesViewController.tabBarItem = UITabBarItem(title: "Favoritos", image: favoritesImage, tag: 1)

        // Set view controllers
        self.viewControllers = [moviesViewController, favoritesViewController]

        // Upgrade background
        self.tabBar.tintColor = UIColor(named: "tabbar-tint-color")
        self.tabBar.barTintColor = UIColor(named: "tabbar-background-color")

//        NetworkManager().request(
//            endpoint: MovieEndpoint.getPopularMovies(page: 1),
//            withDecodeType: MovieList.self) { (result, cached) in
//            print("Received from cache: \(cached)\nData: ", result)
//        }
    }
}
