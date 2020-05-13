//
//  AlertView.swift
//  Tembici Movies
//
//  Created by Guilherme Baldissera on 13/05/20.
//  Copyright © 2020 Guilherme Baldissera. All rights reserved.
//

import UIKit

enum AlertViewType {
    case loading
    case error(message: String)
    case searching
    case searchFailed(message: String)
    case withoutFavorites
}

class AlertView: UIView {

    // MARK: Properties
    private let alertType: AlertViewType
    private var imageView: UIImageView!
    private var label: UILabel!
    private var stackView: UIStackView!

    // MARK: Constructors

    init(with alertType: AlertViewType) {
        // Save properties
        self.alertType = alertType

        // Call super init
        super.init(frame: .zero)

        // Call to setup view layout
        setupComponents()

        // Adjust info based on alert type
        configureAlertType()
    }

    required init?(coder: NSCoder) {
        self.alertType = .loading
        super.init(frame: .zero)
    }

    // MARK: Setup View

    private func setupComponents() {
        createComponents()
        showComponents()
        adjustConstraints()
    }

    private func createComponents() {
        // Create StackView to put components inside
        stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 30

        // Create Label to get message
        label = UILabel()
        label.font = label.font.withSize(20)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false

        // Create ImageView to show alert icon
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func showComponents() {
        // Add itens on stack view
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)

        // Add stack on view
        addSubview(stackView)
    }

    private func adjustConstraints() {
        // ImageView constraints
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true

        // Label constraints
        label.heightAnchor.constraint(equalToConstant: 35).isActive = true

        // StackView constraints
        stackView.leadingAnchor.constraint(
            equalToSystemSpacingAfter: self.leadingAnchor,
            multiplier: 0).isActive = true
        stackView.trailingAnchor.constraint(
            equalToSystemSpacingAfter: self.trailingAnchor,
            multiplier: 0).isActive = true
        NSLayoutConstraint(
            item: stackView as Any,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerY,
            multiplier: 1,
            constant: -100).isActive = true
    }

    // MARK: Private Methods

    private func configureAlertType() {
        // Default values
        imageView.image = nil
        label.text = nil

        // Configure alert
        switch alertType {
        case .loading:
            label.text = NSLocalizedString("Carregando", comment: "Getting data")
            imageView.image = UIImage(named: "icon-loading")

        case .searching:
            label.text = NSLocalizedString("Buscando", comment: "Searching")
            imageView.image = UIImage(named: "icon-search")

        case let .searchFailed(message):
            label.text = message
            imageView.image = UIImage(named: "icon-search-failed")

        case let .error(message):
            label.text = message
            imageView.image = UIImage(named: "icon-info")

        case .withoutFavorites:
            label.text = NSLocalizedString("Sem favoritos", comment: "Without favorites (Friendly)")
            imageView.image = UIImage(named: "icon-without-favorites")
        }
    }
}
