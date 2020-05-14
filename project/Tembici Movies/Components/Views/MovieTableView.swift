//
//  MovieTableView.swift
//  Tembici Movies
//
//  Created by Guilherme Baldissera on 13/05/20.
//  Copyright © 2020 Guilherme Baldissera. All rights reserved.
//

import UIKit

// MARK: - DataSource Protocol

protocol MovieTableDataSource: class {
    func numberOfMovies(_ movieTable: MovieTableView) -> Int
    func footerTitle(_ movieTable: UITableView) -> String?
    func movieTable(_ movieTable: UITableView, movieAt indexPath: IndexPath) -> SimpleMovie
}

// MARK: - Delegate Protocol

protocol MovieTableDelegate: class {
    func willShowFooter(_ movieTable: UITableView)
    func movieTable(_ movieTable: UITableView, didSelectMovie indexPath: IndexPath)
}

class MovieTableView: UITableView {

    // MARK: Properties

    weak var movieDataSource: MovieTableDataSource?
    weak var movieDelegate: MovieTableDelegate?

    // MARK: Constructors

    init(movieDataSource: MovieTableDataSource? = nil, movieDelegate: MovieTableDelegate? = nil) {
        // Set Properties
        self.movieDataSource = movieDataSource
        self.movieDelegate = movieDelegate

        // Super init
        super.init(frame: .zero, style: .grouped)

        // Setup tableView
        self.setupTableView()
    }

    required init?(coder: NSCoder) {
        super.init(frame: .zero, style: .grouped)

        // Setup tableView
        self.setupTableView()
    }

    // MARK: Setup Table

    private func setupTableView() {
        dataSource = self
        delegate = self
        self.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

// MARK: - TableView Extension with DataSourre

extension MovieTableView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieDataSource?.numberOfMovies(self) ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell

        // Get Movie and show on table
        if let movie = movieDataSource?.movieTable(self, movieAt: indexPath) {
            cell = dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = movie.name
        } else {
            cell = UITableViewCell()
        }

        // Default config
//        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - TableView Extension with Delegate

extension MovieTableView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        self.movieDelegate?.willShowFooter(self)
    }

    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return self.movieDataSource?.footerTitle(self)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.movieDelegate?.movieTable(self, didSelectMovie: indexPath)
    }
}
