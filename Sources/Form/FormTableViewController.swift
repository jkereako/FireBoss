//
//  FormTableViewController.swift
//  FireBoss
//
//  Created by Jeff Kereakoglow on 4/22/18.
//  Copyright © 2018 AlexisDigital. All rights reserved.
//

import UIKit

protocol FormTableViewDelegate: class {
    func didSubmitForm(viewModel: [FormTableViewModel])
}

final class FormTableViewController: UITableViewController {
    weak var delegate: FormTableViewDelegate?
    var viewModel: [FormTableViewModel]!

    private var dataSource: FormTableViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var buttonIndexes = [Int]()

        // Find all of the buttons in the view model
        for i in 0..<viewModel.count {
            switch viewModel[i].type {
            case .button:
                buttonIndexes.append(i)

            default:
                break
            }
        }

        // HACK: Reset the target of each button to this class
        buttonIndexes.forEach {
            let old = viewModel[$0]

            viewModel[$0] = FormTableViewModel(
                type: .button(target: self, action: #selector(submitAction(_:))),
                valueModel: old.valueModel,
                error: old.error
            )
        }

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
    // We use this method to capture the user's input as he types
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {

        guard let indexPath = tableView.indexPath(for: textField),
            let model = dataSource?.rowModel(at: indexPath) else {
                assertionFailure("Expected a value")
                return true
        }

        let newViewModel = FormTableViewModel(
            type: model.type, valueModel: model.valueModel, error: model.error
        )

        dataSource?.setRowModel(newViewModel, at: indexPath)

        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let indexPath = tableView.indexPath(for: textField),
            let model = dataSource?.rowModel(at: indexPath) else {
                assertionFailure("Expected a value")
                return true
        }

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
extension FormTableViewController {
    @IBAction func submitAction(_ sender: UIButton) {
        guard let ds = dataSource, let vm = ds.viewModel else {
            assertionFailure("Expected a value")
            return
        }

        delegate?.didSubmitForm(viewModel: vm)
    }
}
