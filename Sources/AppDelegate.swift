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
    var appCoordinator: AppCoordinator?
}

// MARK: - UIApplicationDelegate
extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        // The ol' fashioned way.
        window = UIWindow(frame: UIScreen.main.bounds)

        appCoordinator = AppCoordinator(window: window!)
        appCoordinator!.start()
        
        return true
    }
}
