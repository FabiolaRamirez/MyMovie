//
//  MoviesSavedPresenter.swift
//  MyMovieDB
//
//  Created by Fabiola Ramirez on 9/1/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import Foundation
import Firebase

protocol MoviesSavedPresenterDelegate {
    func deleteMovie(movie: Movie)
    func getMovies() -> [Movie]
    func validateAuthentication()
}

protocol MovieSavedProtocol: AnyObject {
    func successfullyMovieDeleted()
    func validateAuthFinished()
}

class MoviesSavedPresenter: MoviesSavedPresenterDelegate {
    
    weak var view: MovieSavedProtocol?
    
    init(view: MovieSavedProtocol) {
        self.view = view
    }
    
    func deleteMovie(movie: Movie) {
        RDatabase.deleteMovie(movie)
        view?.successfullyMovieDeleted()
    }
    
    func getMovies() -> [Movie] {
        let movies = RDatabase.fetchMovies()
        return movies
    }
    
    func validateAuthentication() {
        if Auth.auth().currentUser == nil {
            self.view?.validateAuthFinished()
        }
    }

}
