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
        let moviesTitle = NSLocalizedString("Filmes", comment: "Movies")
        let moviesViewController = MoviesViewController()
        moviesViewController.tabBarItem = UITabBarItem(title: moviesTitle, image: moviesImage, tag: 0)

        // Create FavoriteViewController
        let favoritesImage = UIImage(named: "icon-tabbar-favorites")
        let favoritesTitle = NSLocalizedString("Favoritos", comment: "Favorites")
        let favoritesViewController = FavoritesViewController()
        favoritesViewController.tabBarItem = UITabBarItem(title: favoritesTitle, image: favoritesImage, tag: 1)

        // Set view controllers
        self.viewControllers = [moviesViewController, favoritesViewController]

        // Upgrade background
        self.tabBar.tintColor = UIColor(named: "tabbar-tint-color")
        self.tabBar.barTintColor = UIColor(named: "tabbar-background-color")
    }
}
