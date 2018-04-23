//
//  TableViewCellType.swift
//  FireBoss
//
//  Created by Jeff Kereakoglow on 4/22/18.
//  Copyright © 2018 AlexisDigital. All rights reserved.
//

import UIKit

enum TableViewCellType {
    case textField(
        isSecureTextEntry: Bool,
        keyboardType: UIKeyboardType,
        returnKeyType: UIReturnKeyType,
        delegate: UITextFieldDelegate
    )
    case button(target: NSObject, action: Selector)
}
