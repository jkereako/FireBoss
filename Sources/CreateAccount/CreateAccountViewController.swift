//
//  CreateAccountViewController.swift
//  FireBoss
//
//  Created by Jeff Kereakoglow on 4/25/18.
//  Copyright © 2018 AlexisDigital. All rights reserved.
//

import UIKit

protocol CreateAccountViewDelegate: class {
    func didTapSignInButton(email: String, password: String)
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
            barButtonSystemItem: .done, target: self, action: #selector(doneBarButtonItemAction(_:))
        )

        let formTableViewController = FormTableViewController()

        formContainerHeightConstraint.constant = formTableViewController.tableView.rowHeight * 3

        addChildViewController(formTableViewController, toView: formContainer)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        view.endEditing(true)
    }
}

// MARK: - Target-actions
extension CreateAccountViewController {
    @IBAction func doneBarButtonItemAction(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true)
    }
}
