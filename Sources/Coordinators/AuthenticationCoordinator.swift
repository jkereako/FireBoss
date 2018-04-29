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
    func didTapSignInButton(formValues: [FormValueModel]) {
        var values = [String: String]()

        formValues.forEach { values[$0.label.lowercased()] = $0.value }

        authenticationServiceClient.signInWithEmail(values["email"]!, password: values["password"]!)
        { (error) in
            guard error == nil else {
                let alertController = UIAlertController(
                    title: "Sign In Failed",
                    message: "Your email or password were incorrect. Please try again.",
                    preferredStyle: .alert
                )

                alertController.addAction(UIAlertAction(title: "OK", style: .default))

                self.navigationController.topViewController?.present(alertController, animated: true)

                return
            }

            print("Sign in succeeded!")
        }
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
