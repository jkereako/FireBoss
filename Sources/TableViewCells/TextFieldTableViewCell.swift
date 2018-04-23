//
//  TextFieldTableViewCell.swift
//  FireBoss
//
//  Created by Jeff Kereakoglow on 4/20/18.
//  Copyright © 2018 AlexisDigital. All rights reserved.
//

import UIKit

final class TextFieldTableViewCell: UITableViewCell, FormTableViewCell {
    var viewModel: FormTableViewModel? {
        didSet {
            guard let model = viewModel else {
                assertionFailure("Expected a value")
                return
            }

            switch model.type {
            case .textField(let isSecureTextEntry, let keyboardType, let returnKeyType, let delegate):
                textField.isSecureTextEntry = isSecureTextEntry
                textField.returnKeyType = returnKeyType
                textField.delegate = delegate
                textField.keyboardType = keyboardType
                textField.autocorrectionType = .no
            default:
                break
            }

            label.text = model.label
            error.text = model.error
            textField.text = model.value
        }
    }


    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var error: UILabel!
    @IBOutlet private weak var textField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()

        label.text = nil
        error.text = nil
        textField.placeholder = nil
        textField.text = nil
    }
}
