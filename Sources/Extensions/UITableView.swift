//
//  UITableView.swift
//  FireBoss
//
//  Created by Jeff Kereakoglow on 4/22/18.
//  Copyright © 2018 AlexisDigital. All rights reserved.
//

import UIKit.UITableView

extension UITableView {
    func registerNibsWithReuseIdentifierMap(_ reuseIdentifierMap: [String: UITableViewCell.Type]) {
        reuseIdentifierMap.forEach { (reuseIdentifier, cellType) in
            let nib = UINib(nibName: reuseIdentifier, bundle: Bundle(for: cellType))
            self.register(nib, forCellReuseIdentifier: reuseIdentifier)
        }
    }
}
