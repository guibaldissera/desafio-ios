//
//  ViewController.swift
//  Tembici Movies
//
//  Created by Guilherme Baldissera on 08/05/20.
//  Copyright © 2020 Guilherme Baldissera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.systemYellow
        NetworkManager().request(
            endpoint: MovieEndpoint.getPopularMovies(page: 1),
            withDecodeType: MovieList.self) { result in
            print(result)
        }
    }
}
