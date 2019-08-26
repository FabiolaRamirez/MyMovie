//
//  LoginViewController.swift
//  MyMovieDB
//
//  Created by Fabiola Ramirez on 7/18/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import Foundation
import UIKit

protocol LoginPresenterDelegate {
    func loginUser(email: String, password: String)
}


class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    var loginPresenter: LoginPresenterDelegate?
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super .viewDidLoad()
        self.loginPresenter = LoginPresenter(delegate: self)
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func login(_ sender: UIButton) {
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
        
        loginPresenter?.loginUser(email: email, password: password)
        
    }
    

    @IBAction func signup(_ sender: UIButton) {
        let vc: SignUpViewController = UIViewController.instantiateViewController(storyBoard: "User", identifier: "signUpViewController") as! SignUpViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    func setupUI() {
        view.backgroundColor = UIColor.orangePrimary
        titleLabel.font = UIFont.neueBold(27)
        titleLabel.textColor = .white
        titleLabel.text = "My Movie".localized
        loginButton.setSecondTheme(title: "Log In".localized)
        
        signupButton.setTitleColor(UIColor.white, for: .normal)
        signupButton.setTitle("Sign Up".localized, for: .normal)
        signupButton.titleLabel?.font = UIFont.neueBold(14)
        
        emailTextfield.attributedPlaceholder = NSAttributedString(string: "Enter email".localized, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        passwordTextfield.attributedPlaceholder = NSAttributedString(string: "Enter password".localized, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
    }
    
}

extension LoginViewController: LoginProtocol {
    
    func loginSuccessful() {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func loginError(message: String) {
        showSimpleAlert(title: "", message: message)
    }
    
    func startActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }

}
