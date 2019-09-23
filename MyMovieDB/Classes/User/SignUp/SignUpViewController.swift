//
//  SignUpViewController.swift
//  MyMovieDB
//
//  Created by Fabiola Ramirez on 7/18/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import Foundation
import UIKit
import Firebase

protocol SignUpPresenterDelegate {
    func registerUser(email: String, password: String)
}

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    var signUpPresenter: SignUpPresenterDelegate?
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super .viewDidLoad()
        self.signUpPresenter = SignUpPresenter(delegate: self)
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func signup(_ sender: UIButton) {
        let email = emailTextfield?.text ?? ""
        let password = passwordTextfield?.text ?? ""
        
        guard !email.isEmpty else {
            showSimpleAlert(title: "", message: "FillEmailFieldMessage".localized)
            return
        }
        guard !password.isEmpty else {
            showSimpleAlert(title: "", message: "FillPasswordFieldMessage".localized)
            return
        }
        signUpPresenter?.registerUser(email: email, password: password)
    
    }
    
    @IBAction func login(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func setupUI() {
        view.backgroundColor = UIColor.orangePrimary
        titleLabel.font = UIFont.neueBold(27)
        titleLabel.textColor = .white
        titleLabel.text = "My Movie".localized
        signupButton.setSecondTheme(title: "Sign Up".localized)
        
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.setTitle("Log In".localized, for: .normal)
        loginButton.titleLabel?.font = UIFont.neueBold(14)
        
        emailLabel.textColor = UIColor.white
        emailLabel.text = "Email".localized
        emailLabel.font = UIFont.neueRegular(14)
        
        passwordLabel.textColor = UIColor.white
        passwordLabel.text = "Password".localized
        passwordLabel.font = UIFont.neueRegular(14)
        
        emailTextfield.attributedPlaceholder = NSAttributedString(string: "Enter".localized, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        passwordTextfield.attributedPlaceholder = NSAttributedString(string: "Enter".localized, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        emailTextfield.accessibilityIdentifier = AccessibilityContants.emailSignUpTextFieldId
        passwordTextfield.accessibilityIdentifier = AccessibilityContants.passwordSignUpTextFieldId
        signupButton.accessibilityIdentifier = AccessibilityContants.signUpButtonId
        
    }
    
}

extension SignUpViewController: SignUpProtocol {
    
    func registerSuccessful() {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func signUpError(message: String) {
        showSimpleAlert(title: "", message: message)
    }
    
    func startActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
}
