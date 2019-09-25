//
//  AddMoviesPresenter.swift
//  MyMovieDB
//
//  Created by Fabiola Ramirez on 9/3/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import Foundation

protocol AddMoviesPresenterDelegate {
    func searchMovies()
}

protocol AddMoviesProtocol: AnyObject {
    func taskFinished()
    func updateUIWhenTaskstarts()
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
    
}
