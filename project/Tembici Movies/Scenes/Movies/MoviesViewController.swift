//
//  MoviesViewController.swift
//  Tembici Movies
//
//  Created by Guilherme Baldissera on 12/05/20.
//  Copyright © 2020 Guilherme Baldissera. All rights reserved.
//

import UIKit

// MARK: - Movies DisplayLogic Protocol

protocol MoviesDisplayLogic: class {
    func displayMovies(viewModel: Movies.GetMovies.ViewModel)
}

// MARK: - Movies ViewController Class

class MoviesViewController: UIViewController {

    // MARK: Scene Properties
    var interactor: MoviesBusinessLogic?
    var router: (NSObjectProtocol & MoviesRoutingLogic & MoviesDataPassing)?

    // MARK: View Properties
    var alertView: AlertView?
    var tableView: UITableView?

    // MARK: Other Properties

    // MARK: Object lifecycle

    init() {
        super.init(nibName: nil, bundle: nil)
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup view with objects
        self.setupView()

        // Get data from server
        self.getMovieList()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = MoviesInteractor()
        let presenter = MoviesPresenter()
        let router = MoviesRouter()
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

        self.createAlertView(type: .loading)
    }

    // MARK: Routing Methods

    // MARK: Interactor Method Calls

    /// Call interactor to get movie list
    func getMovieList() {
        let request = Movies.GetMovies.Request()
        interactor?.getMovies(request: request)
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

// MARK: - Movies ViewController Extension with DisplayLogic

extension MoviesViewController: MoviesDisplayLogic {

    func displayMovies(viewModel: Movies.GetMovies.ViewModel) {}
}
