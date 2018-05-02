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
    private let authenticationServiceClient: AuthenticationServiceClient

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        authenticationServiceClient = AuthenticationServiceClient()
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
    func didTapSignInButton(from viewController: UIViewController, with formValues: [FormValueModel]) {
        var values = [String: String]()

        formValues.forEach { values[$0.label.lowercased()] = $0.value }

        authenticationServiceClient.signInWithEmail(values["email"]!, password: values["password"]!)
        { (error) in
            guard let err = error else {
                print("Sign in succeeded!")

                return
            }

            let title = "Sign In Failed"
            let message = err.localizedDescription
            let alertController = self.alertControllerWithTitle(title, message: message)

            viewController.present(alertController, animated: true)
        }
    }

    func didTapCreateAccountButton(from viewController: UIViewController) {
        let viewController = CreateAccountViewController()
        viewController.delegate = self

        navigationController.present(
            UINavigationController(rootViewController: viewController), animated: true
        )
    }
}

// MARK: - CreateAccountViewDelegate
extension AuthenticationCoordinator: CreateAccountViewDelegate {
    func didTapCreateAccountButton(from viewController: UIViewController,
                                   with formValues: [FormValueModel]) {
        var values = [String: String]()

        formValues.forEach { values[$0.label.lowercased()] = $0.value }

        authenticationServiceClient.signInWithEmail(values["email"]!, password: values["password"]!)
        { (error) in
            var title = "You're Registered!"
            var message = "Your account was created successfully!"

            if let err = error {
                title = "Something's Wrong"
                message = err.localizedDescription
            }

            let alertController = self.alertControllerWithTitle(title, message: message)

            viewController.present(alertController, animated: true)
        }
    }
}

// MARK: - Private helper methods
private extension AuthenticationCoordinator {
    func alertControllerWithTitle(_ title: String, message: String) -> UIAlertController {
        let alertController = UIAlertController(
            title: title, message: message, preferredStyle: .alert
        )

        alertController.addAction(UIAlertAction(title: "OK", style: .default))

        return alertController
    }
}
