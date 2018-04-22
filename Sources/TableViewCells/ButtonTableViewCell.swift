//
//  ButtonTableViewCell.swift
//  FireBoss
//
//  Created by Jeff Kereakoglow on 4/22/18.
//  Copyright © 2018 AlexisDigital. All rights reserved.
//

import UIKit

final class ButtonTableViewCell: UITableViewCell, FormTableViewCell {
    var viewModel: FormTableViewModel? {
        didSet {
            guard let model = viewModel else {
                assertionFailure("Expected a value")
                return
            }
            
            button.setTitle(model.label, for: .normal)
        }
    }
    
    @IBOutlet private weak var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        button.setTitle(nil, for: .normal)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
