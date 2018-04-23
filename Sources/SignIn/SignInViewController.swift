//
//  SignInViewController.swift
//  FireBoss
//
//  Created by Jeff Kereakoglow on 4/22/18.
//  Copyright © 2018 AlexisDigital. All rights reserved.
//

import UIKit

final class SignInViewController: UIViewController {
    @IBOutlet private weak var formContainerHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var formContainer: UIView!

    init() {
        super.init(nibName: "SignInView", bundle: Bundle(for: SignInViewController.self))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let formTableViewController = SignInTableViewController()

        formContainerHeightConstraint.constant = formTableViewController.tableView.rowHeight * 3

        addChildViewController(formTableViewController, toView: formContainer)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        view.endEditing(true)
    }
}
