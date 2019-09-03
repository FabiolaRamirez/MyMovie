//
//  LoginPresenter.swift
//  MyMovieDB
//
//  Created by Fabiola Ramirez on 7/31/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import Foundation
import Firebase

protocol LoginProtocol: class {
    func loginSuccessful()
    func loginError(message: String)
    func startActivityIndicator()
    func stopActivityIndicator()
}

class LoginPresenter: LoginPresenterDelegate {
    
   weak var delegate: LoginProtocol?
    
    init(delegate: LoginProtocol) {
        self.delegate = delegate
    }
    
    func loginUser(email: String, password: String) {
        delegate?.startActivityIndicator()
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            self.delegate?.stopActivityIndicator()
            if let error = error {
                self.delegate?.loginError(message: "ErrorMessage".localized)
                print("Failed to sign in user: \(error.localizedDescription)")
                return
            }
            self.delegate?.loginSuccessful()
        }
    }
    
}
