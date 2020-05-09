//
//  SceneDelegate.swift
//  Tembici Movies
//
//  Created by Guilherme Baldissera on 08/05/20.
//  Copyright © 2020 Guilherme Baldissera. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: - Properties
    var window: UIWindow?

    // MARK: - Methods
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Get current window scene
        guard let windowScene = scene as? UIWindowScene else { return }

        // Update window with window scene
        let window = UIWindow(windowScene: windowScene)
        self.window = window

        // Update view showed in window
        window.rootViewController = ViewController()

        // Show view
        window.makeKeyAndVisible()
    }
}
