//
//  FavoritesViewController.swift
//  Tembici Movies
//
//  Created by Guilherme Baldissera on 12/05/20.
//  Copyright © 2020 Guilherme Baldissera. All rights reserved.
//

import UIKit

// MARK: - Favorites DisplayLogic Protocol

protocol FavoritesDisplayLogic: class {
    func displaySomething(viewModel: Favorites.Something.ViewModel)
}

// MARK: - Favorites ViewController Class

class FavoritesViewController: UIViewController {

    // MARK: Scene Properties
    var interactor: FavoritesBusinessLogic?
    var router: (NSObjectProtocol & FavoritesRoutingLogic & FavoritesDataPassing)?

    // MARK: View Properties

    // MARK: Other Properties

    // MARK: Object lifecycle

    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBlue
        doSomething()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = FavoritesInteractor()
        let presenter = FavoritesPresenter()
        let router = FavoritesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: Routing Methods

    // MARK: Interactor Method Calls

    func doSomething() {
        let request = Favorites.Something.Request()
        interactor?.doSomething(request: request)
    }
}

// MARK: - Favorites ViewController Extension with DisplayLogic

extension FavoritesViewController: FavoritesDisplayLogic {

    func displaySomething(viewModel: Favorites.Something.ViewModel) {}
}
