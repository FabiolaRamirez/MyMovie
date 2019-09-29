//
//  HomePresenter.swift
//  MyMovieDB
//
//  Created by Fabiola Ramirez on 9/29/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import Foundation
import Firebase

protocol HomePresenterDelegate {
    func stateDidChangeListener()
    func verifyIfUserIsAuth()
    func verifyListOfMovies()
}

protocol HomeProtocol: AnyObject {
    func refreshViews()
    func userIsAuth()
    func userNoAuth()
    func listOfMoviesIsEmpty()
    func listOfMoviesNoEmpty()
}

class HomePresenter: HomePresenterDelegate {
    
   weak var view: HomeProtocol?
    
    init(view: HomeProtocol) {
        self.view = view
    }
    
    func stateDidChangeListener() {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            self.view?.refreshViews()
        }
    }
    
    func verifyIfUserIsAuth() {
        if Auth.auth().currentUser == nil {
            view?.userNoAuth()
        } else {
            view?.userIsAuth()
        }
    }
    
    func verifyListOfMovies() {
        let movies = RDatabase.fetchMovies()
        if movies.isEmpty {
            view?.listOfMoviesIsEmpty()
        } else {
            view?.listOfMoviesNoEmpty()
        }
    }
    
    
}
