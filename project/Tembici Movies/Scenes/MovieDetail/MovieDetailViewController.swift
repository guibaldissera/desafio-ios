//
//  MovieDetailViewController.swift
//  Tembici Movies
//
//  Created by Guilherme Baldissera on 12/05/20.
//  Copyright © 2020 Guilherme Baldissera. All rights reserved.
//

import UIKit

// MARK: - MovieDetail DisplayLogic Protocol

protocol MovieDetailDisplayLogic: class {
    func displaySomething(viewModel: MovieDetail.Something.ViewModel)
}

// MARK: - MovieDetail ViewController Class

class MovieDetailViewController: UIViewController {

    // MARK: Scene Properties
    var interactor: MovieDetailBusinessLogic?
    var router: (NSObjectProtocol & MovieDetailRoutingLogic & MovieDetailDataPassing)?

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
        doSomething()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = MovieDetailInteractor()
        let presenter = MovieDetailPresenter()
        let router = MovieDetailRouter()
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
        let request = MovieDetail.Something.Request()
        interactor?.doSomething(request: request)
    }
}

// MARK: - MovieDetail ViewController Extension with DisplayLogic

extension MovieDetailViewController: MovieDetailDisplayLogic {

    func displaySomething(viewModel: MovieDetail.Something.ViewModel) {}
}
