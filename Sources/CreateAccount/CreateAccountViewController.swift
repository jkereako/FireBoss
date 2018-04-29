//
//  CreateAccountViewController.swift
//  FireBoss
//
//  Created by Jeff Kereakoglow on 4/25/18.
//  Copyright © 2018 AlexisDigital. All rights reserved.
//

import UIKit

protocol CreateAccountViewDelegate: class {
    func didTapCreateAccountButton(email: String, password: String)
}

final class CreateAccountViewController: UIViewController {
    weak var delegate: CreateAccountViewDelegate?

    @IBOutlet private weak var formContainerHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var formContainer: UIView!

    init() {
        super.init(nibName: "CreateAccountView", bundle: Bundle(for: SignInViewController.self))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .done, target: self, action: #selector(doneAction(_:))
        )

        let formTableViewController = FormTableViewController()
        formTableViewController.delegate = self

        // Hard-code the view model
        let viewModel = [
            FormTableViewModel(
                type: .textField(
                    isSecureTextEntry: false,
                    keyboardType: .emailAddress,
                    returnKeyType: .next,
                    delegate: formTableViewController
                ),
                label: "EMAIL"
            ),
            FormTableViewModel(
                type: .textField(
                    isSecureTextEntry: true,
                    keyboardType: .default,
                    returnKeyType: .done,
                    delegate: formTableViewController
                ),
                label: "PASSWORD"
            ),
            FormTableViewModel(
                type: .button(target: nil, action: nil),
                label: "CREATE ACCOUNT"
            )
        ]

        formTableViewController.viewModel = viewModel
        formContainerHeightConstraint.constant = formTableViewController.tableView.rowHeight * CGFloat(viewModel.count * 2)

        addChildViewController(formTableViewController, toView: formContainer)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        view.endEditing(true)
    }
}

// MARK: - FormTableViewDelegate
extension CreateAccountViewController: FormTableViewDelegate {
    func didSubmitForm(viewModel: [FormTableViewModel]) {
        view.endEditing(true)

        delegate?.didTapCreateAccountButton(email: "email", password: "password")
    }
}

// MARK: - Target-actions
extension CreateAccountViewController {
    @IBAction func doneAction(_ sender: UIBarButtonItem) {
        view.endEditing(true)

        navigationController?.dismiss(animated: true)
    }
}
