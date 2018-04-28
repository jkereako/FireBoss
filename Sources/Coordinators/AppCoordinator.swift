//
//  AppCoordinator.swift
//  FireBoss
//
//  Created by Jeff Kereakoglow on 4/27/18.
//  Copyright © 2018 AlexisDigital. All rights reserved.
//

import UIKit
import Firebase

final class AppCoordinator: Coordinatable {
    private let window: UIWindow
    private var childCoordinators: [Coordinatable]

    init(window: UIWindow) {
        self.window = window
        childCoordinators = [Coordinatable]()
    }

    func start() {
        FirebaseApp.configure()

        let navigationController = UINavigationController(nibName: nil, bundle: nil)

        // The ol' fashioned way.
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        childCoordinators.append(
            AuthenticationCoordinator(navigationController: navigationController)
        )

        childCoordinators.last?.start()
    }
}
