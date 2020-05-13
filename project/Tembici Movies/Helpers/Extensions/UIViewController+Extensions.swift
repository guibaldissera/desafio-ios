//
//  UIViewController+Extensions.swift
//  Tembici Movies
//
//  Created by Guilherme Baldissera on 13/05/20.
//  Copyright © 2020 Guilherme Baldissera. All rights reserved.
//

import UIKit

extension UIViewController {

    func constraintsToSuperview(_ view: UIView) {
        // Creating constraints
        view.leadingAnchor.constraint(
            equalToSystemSpacingAfter: self.view.leadingAnchor,
            multiplier: 0).isActive = true
        view.trailingAnchor.constraint(
            equalToSystemSpacingAfter: self.view.trailingAnchor,
            multiplier: 0).isActive = true
        view.topAnchor.constraint(
            equalToSystemSpacingBelow: self.view.topAnchor,
            multiplier: 0).isActive = true
        view.bottomAnchor.constraint(
            equalToSystemSpacingBelow: self.view.bottomAnchor,
            multiplier: 0).isActive = true

        // Update view with new components
        self.view.layoutIfNeeded()
    }
}
