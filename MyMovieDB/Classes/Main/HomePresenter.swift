//
//  HomePresenter.swift
//  MyMovieDB
//
//  Created by Fabiola Ramirez on 9/3/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import Foundation
import Firebase

protocol HomePresenterDelegate {
    func searchMovies()
    func validateAuthentication()
}

protocol HomeProtocol: AnyObject {
    func taskFinished()
    func updateUIWhenTaskstarts()
    func authenticationValidationFinished()
}

class HomePresenter: HomePresenterDelegate {
    
    weak var view: HomeProtocol?
    
    init(view: HomeProtocol) {
        self.view = view
    }
    
    func searchMovies() {
        view?.updateUIWhenTaskstarts()
        Service.shared.searchMovies {
            self.view?.taskFinished()
        }
    }
    
    func validateAuthentication() {
        if Auth.auth().currentUser == nil {
            self.view?.authenticationValidationFinished()
        }
    }
    
}
