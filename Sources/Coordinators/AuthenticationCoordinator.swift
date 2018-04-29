//
//  AuthenticationCoordinator.swift
//  FireBoss
//
//  Created by Jeff Kereakoglow on 4/27/18.
//  Copyright © 2018 AlexisDigital. All rights reserved.
//

import UIKit

final class AuthenticationCoordinator: Coordinatable {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = SignInViewController()
        viewController.delegate = self

        navigationController.pushViewController(viewController, animated: false)
    }

    deinit {
        let url = URL(fileURLWithPath: #file)
        print("Deinit \(url.lastPathComponent)")
    }
}

// MARK: SignInViewDelegate
extension AuthenticationCoordinator: SignInViewDelegate {
    func didTapSignInButton(formValues: [FormValueModel]) {
        print(#function)
    }

    func didTapCreateAccountButton() {
        let viewController = CreateAccountViewController()
        viewController.delegate = self

        navigationController.present(
            UINavigationController(rootViewController: viewController), animated: true
        )
    }
}

// MARK: - CreateAccountViewDelegate
extension AuthenticationCoordinator: CreateAccountViewDelegate {
    func didTapCreateAccountButton(email: String, password: String) {
        print(#function)
    }
}
