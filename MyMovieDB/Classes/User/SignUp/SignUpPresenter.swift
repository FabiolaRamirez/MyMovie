//
//  SignUpPresenter.swift
//  MyMovieDB
//
//  Created by Fabiola Ramirez on 7/31/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import Foundation
import UIKit
import Firebase

protocol SignUpProtocol: class {
    func registerSuccessful()
    func signUpError(message: String)
    func startActivityIndicator()
    func stopActivityIndicator()
}

class SignUpPresenter: SignUpPresenterDelegate {
    
    weak var delegate: SignUpProtocol?
    
    init(delegate: SignUpProtocol) {
        self.delegate = delegate
    }
    
    func registerUser(email: String, password: String) {
        delegate?.startActivityIndicator()
        Auth.auth().createUser(withEmail: email, password: password, completion: {(result, error) in
            self.delegate?.stopActivityIndicator()
            if let error = error {
                self.delegate?.signUpError(message: "ErrorMessage".localized)
                print("Failed to sign user up: \(error.localizedDescription)")
                return
            }
            
            guard let uid = result?.user.uid else { return }
            
            let values = ["email": email]
            Database.database().reference().child("users").child(uid).updateChildValues(values, withCompletionBlock: {(error,ref) in
                if let error = error {
                    print("Failed to update database values: \(error.localizedDescription)")
                    return
                }
                self.delegate?.registerSuccessful()
            })
            
        })
    }

    
    
}
