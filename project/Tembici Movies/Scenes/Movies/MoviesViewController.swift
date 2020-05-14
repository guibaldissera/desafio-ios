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
    func displayError(message: String)
    func displayNoInternet()
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
    var movies: [SimpleMovie] = []

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

    override func loadView() {
        super.loadView()

        // Setup view with objects
        self.setupView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

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

        self.createTableView()
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
        // Remove actual view
        self.removeAlertView()

        // Create new and configure alert
        alertView = AlertView(with: type)
        alertView!.translatesAutoresizingMaskIntoConstraints = false

        // Add alert to view
        view.addSubview(alertView!)

        // Adjust constraints
        self.constraintsToSuperview(alertView!)
    }

    private func removeAlertView() {
        if alertView != nil {
            alertView?.removeFromSuperview()
            alertView = nil
        }
    }

    private func createTableView() {
        // Create new table view with movies
        tableView = MovieTableView(movieDataSource: self, movieDelegate: self)
        tableView!.translatesAutoresizingMaskIntoConstraints = false

        // Add alert to view
        view.addSubview(tableView!)

        // Adjust constraints
        self.constraintsToSuperview(tableView!)
        tableView?.isHidden = true
    }
}

// MARK: - Movies ViewController Extension with DisplayLogic

extension MoviesViewController: MoviesDisplayLogic {

    func displayMovies(viewModel: Movies.GetMovies.ViewModel) {
        // Remove alert view if exist
        self.removeAlertView()
        tableView?.isHidden = false

        // Update movies
        movies = viewModel.movies
        tableView?.reloadData()
    }

    func displayError(message: String) {
        self.createAlertView(type: .error(message: message))
    }

    func displayNoInternet() {
        self.createAlertView(type: .withoutInternet)
    }
}

extension MoviesViewController: MovieTableDataSource, MovieTableDelegate {

    func willShowTableEnd(_ movieTable: UITableView) {
        interactor?.getNextMovies(request: Movies.GetMovies.Request())
    }

    func numberOfMovies(_ movieTable: MovieTableView) -> Int {
        return movies.count
    }

    func movieTable(_ movieTable: UITableView, movieAt indexPath: IndexPath) -> SimpleMovie {
        return movies[indexPath.row]
    }
}
