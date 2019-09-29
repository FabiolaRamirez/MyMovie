//
//  SearchMoviesPresenter.swift
//  MyMovieDB
//
//  Created by Fabiola Ramirez on 9/3/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import Foundation

protocol SearchMoviesPresenterDelegate {
    func searchMovies()
}

protocol SearchMoviesProtocol: AnyObject {
    func taskFinished()
    func updateUIWhenTaskstarts()
}

class SearchMoviesPresenter: SearchMoviesPresenterDelegate {
    
    weak var view: SearchMoviesProtocol?
    
    init(view: SearchMoviesProtocol) {
        self.view = view
    }
    
    func searchMovies() {
        view?.updateUIWhenTaskstarts()
        Service.shared.searchMovies {
            self.view?.taskFinished()
        }
    }
    
}
