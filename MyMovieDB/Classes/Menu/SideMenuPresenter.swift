//
//  SideMenuPresenter.swift
//  MyMovieDB
//
//  Created by Fabiola Ramirez on 9/29/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import Foundation
import Firebase

protocol SideMenuPresenterDelegate {
    func logOut()
}

protocol SideMenuProtocol: AnyObject {
    func logOutSuccessful()
    func logOutUnsuccessful(message: String)
}


class SideMenuPresenter: SideMenuPresenterDelegate {
    
   weak var view: SideMenuProtocol?
    
    init(view: SideMenuProtocol) {
        self.view = view
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
            view?.logOutSuccessful()
        } catch let error {
            view?.logOutUnsuccessful(message: "ErrorLogoutMessage".localized)
            print("Failed to sign out: \(error.localizedDescription)")
        }
    }
    
}
