//
//  MoviesSavedPresenter.swift
//  MyMovieDB
//
//  Created by Fabiola Ramirez on 9/1/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import Foundation

protocol MovieSavedProtocol: class {
    func successfullyMovieDeleted()
}

class MoviesSavedPresenter: MoviesSavedPresenterDelegate {
    
    weak var delegate: MovieSavedProtocol?
    
    init(delegate: MovieSavedProtocol) {
        self.delegate = delegate
    }
    
    func deleteMovie(movie: Movie) {
        RDatabase.deleteMovie(movie)
        delegate?.successfullyMovieDeleted()
    }
    
    func getMovies() -> [Movie] {
        let movies = RDatabase.fetchMovies()
        return movies
    }

}
