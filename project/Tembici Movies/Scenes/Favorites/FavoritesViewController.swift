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
    var alertView: AlertView?
    var tableView: UITableView?

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

        // Setup view with objects
        self.setupView()

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

    private func setupView() {
        // Update view Properties
        view.backgroundColor = .systemBackground

        self.createAlertView(type: .withoutFavorites)
    }

    // MARK: Routing Methods

    // MARK: Interactor Method Calls

    func doSomething() {
        let request = Favorites.Something.Request()
        interactor?.doSomething(request: request)
    }

    // MARK: Private Methods

    private func createAlertView(type: AlertViewType) {
        // If exist other alert view showed, remove and clean
        if alertView != nil {
            alertView?.removeFromSuperview()
            alertView = nil
        }

        // Create new and configure alert
        alertView = AlertView(with: type)
        alertView!.translatesAutoresizingMaskIntoConstraints = false

        // Add alert to view
        view.addSubview(alertView!)

        // Adjust constraints
        self.constraintsToSuperview(alertView!)
    }
}

// MARK: - Favorites ViewController Extension with DisplayLogic

extension FavoritesViewController: FavoritesDisplayLogic {

    func displaySomething(viewModel: Favorites.Something.ViewModel) {}
}
