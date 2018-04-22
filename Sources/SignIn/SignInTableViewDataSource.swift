//
//  SignInTableViewDataSource.swift
//  FireBoss
//
//  Created by Jeff Kereakoglow on 4/22/18.
//  Copyright © 2018 AlexisDigital. All rights reserved.
//

import UIKit

final class SignInTableViewDataSource: NSObject {
    var viewModel: [FormTableViewModel]?

    private enum ReuseIdentifier: String {
        case button = "ButtonTableViewCell"
        case textField = "TextFieldTableViewCell"
    }

    init(tableView: UITableView) {
        super.init()

        let reuseIdentifierMap = [
            ReuseIdentifier.button.rawValue: ButtonTableViewCell.self,
            ReuseIdentifier.textField.rawValue: TextFieldTableViewCell.self
        ]

        tableView.registerNibsWithReuseIdentifierMap(reuseIdentifierMap)
    }
}

// MARK: - UITableViewDataSource
extension SignInTableViewDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel![indexPath.row]
        let reuseIdentifier: String

        switch model.type {
        case .button:
            reuseIdentifier = ReuseIdentifier.button.rawValue
        case .textField:
            reuseIdentifier = ReuseIdentifier.textField.rawValue
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

        if var formCell = cell as? FormTableViewCell {
            formCell.viewModel = model
        } else {
            assertionFailure("Expected cell to conform to FormTableViewCell")
        }

        return cell
    }
}
