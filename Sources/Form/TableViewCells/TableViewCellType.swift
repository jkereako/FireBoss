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

// MARK: - Equatable
extension TableViewCellType: Equatable {
    static func == (lhs: TableViewCellType, rhs: TableViewCellType) -> Bool {
        switch (lhs, rhs) {
        case (.textField, .textField): return true
        case (.button, .button): return true
        default: return false
        }
    }
}
