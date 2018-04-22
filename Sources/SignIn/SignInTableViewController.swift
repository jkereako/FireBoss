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
                label: "EMAIL",
                value: "",
                type: .textField(isSecureTextEntry: false, returnKeyType: .next, delegate: self)
            ),
            FormTableViewModel(
                label: "PASSWORD",
                value: "",
                type: .textField(isSecureTextEntry: true,  returnKeyType: .done, delegate: self)
            ),
            FormTableViewModel(
                label: "SIGN IN",
                value: "",
                type: .button(target: self, action: #selector(buttonAction(_:))))
        ]
        
        dataSource = SignInTableViewDataSource(tableView: tableView)
        dataSource?.viewModel = viewModel
        
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.allowsSelection = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate
extension SignInTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
}

// MARK: - Target-actions
extension SignInTableViewController {
    @IBAction func buttonAction(_ sender: UIButton) {
        print("TEST")
    }
}
