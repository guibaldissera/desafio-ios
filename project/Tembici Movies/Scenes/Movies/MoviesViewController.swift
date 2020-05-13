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
    func displaySomething(viewModel: Movies.Something.ViewModel)
}

// MARK: - Movies ViewController Class

class MoviesViewController: UIViewController {

    // MARK: Scene Properties
    var interactor: MoviesBusinessLogic?
    var router: (NSObjectProtocol & MoviesRoutingLogic & MoviesDataPassing)?

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
        self.view.backgroundColor = .systemRed
        doSomething()
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

    // MARK: Routing Methods

    // MARK: Interactor Method Calls

    func doSomething() {
        let request = Movies.Something.Request()
        interactor?.doSomething(request: request)
    }
}

// MARK: - Movies ViewController Extension with DisplayLogic

extension MoviesViewController: MoviesDisplayLogic {

    func displaySomething(viewModel: Movies.Something.ViewModel) {}
}
