//
//  UIViewController.swift
//  FireBoss
//
//  Created by Jeff Kereakoglow on 4/22/18.
//  Copyright © 2018 AlexisDigital. All rights reserved.
//
import UIKit.UIViewController

extension UIViewController {
    func addChildViewController(_ childViewController: UIViewController, toView view: UIView) {
        childViewController.willMove(toParentViewController: self)
        addChildViewController(childViewController)
        childViewController.view.frame = view.bounds
        view.addSubview(childViewController.view)
        childViewController.didMove(toParentViewController: self)
    }

    func removeChildViewController(_ childViewController: UIViewController) {
        childViewController.removeFromParentViewController()
        childViewController.view.removeFromSuperview()
    }
}
