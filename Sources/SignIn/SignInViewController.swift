//
//  SignInViewController.swift
//  FireBoss
//
//  Created by Jeff Kereakoglow on 4/22/18.
//  Copyright © 2018 AlexisDigital. All rights reserved.
//

import UIKit

protocol SignInViewDelegate: class {
    func didTapSignInButton(formValues: [FormValueModel])
    func didTapCreateAccountButton()
}

final class SignInViewController: UIViewController {
    weak var delegate: SignInViewDelegate?
    
    @IBOutlet private weak var formContainerHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var formContainer: UIView!
    
    private var formTableViewController: FormTableViewController!
    
    init() {
        super.init(nibName: "SignInView", bundle: Bundle(for: SignInViewController.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formTableViewController = FormTableViewController()
        formTableViewController.delegate = self
        
        // Hard-code the view model
        let viewModel = [
            FormTableViewModel(
                type: .textField(
                    isSecureTextEntry: false,
                    keyboardType: .emailAddress,
                    returnKeyType: .next,
                    delegate: formTableViewController
                ),
                label: "EMAIL"
            ),
            FormTableViewModel(
                type: .textField(
                    isSecureTextEntry: true,
                    keyboardType: .default,
                    returnKeyType: .done,
                    delegate: formTableViewController
                ),
                label: "PASSWORD"
            ),
            FormTableViewModel(
                type: .button(target: nil, action: nil),
                label: "SIGN IN"
            )
        ]
        
        formTableViewController.viewModel = viewModel
        formContainerHeightConstraint.constant = formTableViewController.tableView.rowHeight * CGFloat(viewModel.count * 2)
        
        addChildViewController(formTableViewController, toView: formContainer)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        view.endEditing(true)
    }
}

// MARK: - FormTableViewDelegate
extension SignInViewController: FormTableViewDelegate {
    func didSubmitForm(viewModel: [FormTableViewModel]) {
        view.endEditing(true)
        
        var values = [FormValueModel]()
        
        viewModel.forEach {
            switch $0.type {
            case .textField:
                values.append(FormValueModel(label: $0.label, value: $0.value))
            default:
                break
            }
            
        }
        
        delegate?.didTapSignInButton(formValues: values)
    }
}


// MARK: - Target-actions
extension SignInViewController {
    @IBAction func createAccountAction(_ sender: UIButton) {
        view.endEditing(true)
        
        delegate?.didTapCreateAccountButton()
    }
}
