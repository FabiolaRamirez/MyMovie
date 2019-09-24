//
//  MoviesSavedPresenter.swift
//  MyMovieDB
//
//  Created by Fabiola Ramirez on 9/1/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import Foundation

protocol MovieSavedProtocol: AnyObject {
    func successfullyMovieDeleted()
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

}
