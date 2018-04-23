//
//  SignInFormTableViewController.swift
//  FireBoss
//
//  Created by Jeff Kereakoglow on 4/22/18.
//  Copyright © 2018 AlexisDigital. All rights reserved.
//

import UIKit

// Created this delegate to avoid confusion
protocol SignInFormTableViewDelegate: SignInViewDelegate {}

final class SignInFormTableViewController: UITableViewController {
    weak var delegate: SignInFormTableViewDelegate?

    private var dataSource: SignInTableViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hard-code the view model
        let viewModel = [
            FormTableViewModel(
                label: "EMAIL",
                value: "",
                error: "",
                type: .textField(
                    isSecureTextEntry: false,
                    keyboardType: .emailAddress,
                    returnKeyType: .next,
                    delegate: self
                )
            ),
            FormTableViewModel(
                label: "PASSWORD",
                value: "",
                error: "",
                type: .textField(
                    isSecureTextEntry: true,
                    keyboardType: .default,
                    returnKeyType: .done,
                    delegate: self
                )
            ),
            FormTableViewModel(
                label: "SIGN IN",
                value: "",
                error: "",
                type: .button(target: self, action: #selector(buttonAction(_:))))
        ]
        
        dataSource = SignInTableViewDataSource(tableView: tableView)
        dataSource?.viewModel = viewModel
        
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.rowHeight = 64
    }
}

// MARK: - UITextFieldDelegate
extension SignInFormTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let indexPath = tableView.indexPath(for: textField),
            let model = dataSource?.rowModel(at: indexPath) else {
                assertionFailure("Expected a value")
                return true
        }

        let newViewModel = FormTableViewModel(
            label: model.label, value: textField.text ?? "", error: model.error, type: model.type
        )

        dataSource?.setRowModel(newViewModel, at: indexPath)

        switch model.type {
        case .textField( _, _, let returnKeyType, _):
            // If the return key reads "Next" or "Continue", then find the next text field
            guard [.next, .continue].contains(returnKeyType) else {
                textField.endEditing(true)
                return true
            }

            // Find the next table view cell
            let cell = tableView.cellForRow(
                at: IndexPath(row: indexPath.row + 1, section: indexPath.section)
            )

            // Find the text field inside the cell and give it focus.
            cell?.contentView.subviews.forEach { subview in
                guard subview is UITextField else { return }

                // Sanity check; if `subview` is the first responder, then we have a circular
                // reference.
                assert(
                    !subview.isFirstResponder,
                    "Did not expect text field to be the first responder"
                )

                // Focus on the text field
                subview.becomeFirstResponder()
            }

            return false
        default:
            break
        }

        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
}

// MARK: - Target-actions
extension SignInFormTableViewController {
    @IBAction func buttonAction(_ sender: UIButton) {
        view.endEditing(true)

        // This should work, don't know why it ain't
        // let textFields = dataSource?.viewModel?.filter { $0.type == TableViewCellType.textField }

        delegate?.didTapSignInButton(email: "email", password: "password")
    }
}
