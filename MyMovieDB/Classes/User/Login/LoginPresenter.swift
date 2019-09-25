//
//  LoginPresenter.swift
//  MyMovieDB
//
//  Created by Fabiola Ramirez on 7/31/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import Foundation
import Firebase

protocol LoginPresenterDelegate {
    func loginUser(email: String, password: String)
}

protocol LoginProtocol: AnyObject {
    func loginSuccessful()
    func loginError(message: String)
    func startActivityIndicator()
    func stopActivityIndicator()
}

class LoginPresenter: LoginPresenterDelegate {
    
   weak var view: LoginProtocol?
    
    init(view: LoginProtocol) {
        self.view = view
    }
    
    func loginUser(email: String, password: String) {
        view?.startActivityIndicator()
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            self.view?.stopActivityIndicator()
            if let error = error {
                self.view?.loginError(message: "ErrorMessage".localized)
                print("Failed to sign in user: \(error.localizedDescription)")
                return
            }
            self.view?.loginSuccessful()
        }
    }
    
}
