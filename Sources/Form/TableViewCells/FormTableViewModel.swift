//
//  FormInTableViewModel.swift
//  FireBoss
//
//  Created by Jeff Kereakoglow on 4/22/18.
//  Copyright © 2018 AlexisDigital. All rights reserved.
//

import Foundation

struct FormTableViewModel {
    let type: TableViewCellType
    let valueModel: FormValueModel
    let error: String
    var label: String { return valueModel.label }
    var value: String { return valueModel.value }
}

extension FormTableViewModel {
    init(type: TableViewCellType, label: String) {
        self.type = type
        valueModel = FormValueModel(label: label, value: "")
        error = ""
    }
}
