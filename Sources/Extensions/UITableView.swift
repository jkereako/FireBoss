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

    func indexPath(for control: UIControl) -> IndexPath? {
        let point: CGPoint
        // Convert the origin of the text field to the coordinate space of the table view
        point = control.superview?.convert(control.frame.origin, to: self) ?? .zero

        return indexPathForRow(at: point)
    }
}
