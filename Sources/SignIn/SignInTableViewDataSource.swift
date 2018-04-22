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

    init(tableView: UITableView) {
        super.init()

        let reuseIdentifierMap = [
            FormTableViewCellReuseIdentifier.button.rawValue: ButtonTableViewCell.self,
            FormTableViewCellReuseIdentifier.textField.rawValue: TextFieldTableViewCell.self
        ]

        tableView.registerNibsWithReuseIdentifierMap(reuseIdentifierMap)
    }

    func viewModel(for indexPath: IndexPath) -> FormTableViewModel? {
        return viewModel?[indexPath.row]
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
            reuseIdentifier = FormTableViewCellReuseIdentifier.button.rawValue
        case .textField:
            reuseIdentifier = FormTableViewCellReuseIdentifier.textField.rawValue
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
