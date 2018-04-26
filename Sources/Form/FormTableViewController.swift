//
//  FormTableViewController.swift
//  FireBoss
//
//  Created by Jeff Kereakoglow on 4/22/18.
//  Copyright © 2018 AlexisDigital. All rights reserved.
//

import UIKit

// Created this delegate to avoid confusion

final class FormTableViewController: UITableViewController {
    var viewModel: [FormTableViewModel]!

    private var dataSource: FormTableViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = FormTableViewDataSource(tableView: tableView)
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
extension FormTableViewController: UITextFieldDelegate {
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
