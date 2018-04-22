//
//  SignInTableViewController.swift
//  FireBoss
//
//  Created by Jeff Kereakoglow on 4/22/18.
//  Copyright © 2018 AlexisDigital. All rights reserved.
//

import UIKit

final class SignInTableViewController: UITableViewController {
    private var dataSource: SignInTableViewDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Hard-code the view model
        let viewModel = [
            FormTableViewModel(
                label: "EMAIL", value: "", type: .textField(isSecureTextEntry: false)
            ),
            FormTableViewModel(
                label: "PASSWORD", value: "", type: .textField(isSecureTextEntry: true)
            ),
            FormTableViewModel(label: "SIGN IN", value: "", type: .button)
        ]

        dataSource = SignInTableViewDataSource(tableView: tableView)
        dataSource?.viewModel = viewModel

        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.allowsSelection = false
    }
}
