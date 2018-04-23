//
//  AppDelegate.swift
//  FireBoss
//
//  Created by Jeff Kereakoglow on 4/20/18.
//  Copyright © 2018 AlexisDigital. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
final class AppDelegate: UIResponder {
    var window: UIWindow?
}

// MARK: - UIApplicationDelegate
extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()
        
        let viewController = SignInViewController()

        // The ol' fashioned way.
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = viewController
        window!.makeKeyAndVisible()

        return true
    }
}
