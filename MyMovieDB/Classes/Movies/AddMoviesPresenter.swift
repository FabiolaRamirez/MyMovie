//
//  AddMoviesPresenter.swift
//  MyMovieDB
//
//  Created by Fabiola Ramirez on 9/3/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import Foundation
import Firebase

protocol AddMoviesPresenterDelegate {
    func searchMovies()
    func validateAuthentication()
}

protocol AddMoviesProtocol: AnyObject {
    func taskFinished()
    func updateUIWhenTaskstarts()
    func validateAuthFinished()
}

class AddMoviesPresenter: AddMoviesPresenterDelegate {
    
    weak var view: AddMoviesProtocol?
    
    init(view: AddMoviesProtocol) {
        self.view = view
    }
    
    func searchMovies() {
        view?.updateUIWhenTaskstarts()
        Service.shared.getMoviesOneSearch {
            self.view?.taskFinished()
        }
    }
    
    func validateAuthentication() {
        if Auth.auth().currentUser == nil {
            self.view?.validateAuthFinished()
            print("entrando pot true")
        } else {
            print("entrando por falso")
        }
    }
    
}
