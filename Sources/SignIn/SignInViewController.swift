//
//  SignInViewController.swift
//  FireBoss
//
//  Created by Jeff Kereakoglow on 4/22/18.
//  Copyright © 2018 AlexisDigital. All rights reserved.
//

import UIKit

protocol SignInViewDelegate: class {
    func didTapSignInButton(email: String, password: String)
    func didTapCreateAccountButton()
}

final class SignInViewController: UIViewController {
    weak var delegate: SignInViewDelegate?

    @IBOutlet private weak var formContainerHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var formContainer: UIView!

    private var formTableViewController: FormTableViewController!

    init() {
        super.init(nibName: "SignInView", bundle: Bundle(for: SignInViewController.self))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        formTableViewController = FormTableViewController()

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
                    delegate: formTableViewController
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
                    delegate: formTableViewController
                )
            ),
            FormTableViewModel(
                label: "SIGN IN",
                value: "",
                error: "",
                type: .button(target: self, action: #selector(buttonAction(_:)))
            )
        ]

        formTableViewController.viewModel = viewModel

        formContainerHeightConstraint.constant = formTableViewController.tableView.rowHeight * 3

        addChildViewController(formTableViewController, toView: formContainer)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        view.endEditing(true)
    }
}


// MARK: - Target-actions
extension SignInViewController {
    @IBAction func buttonAction(_ sender: UIButton) {
        view.endEditing(true)

        delegate?.didTapSignInButton(email: "email", password: "password")
    }

    @IBAction func createAccountAction(_ sender: UIButton) {
        view.endEditing(true)

        delegate?.didTapCreateAccountButton()
    }
}
