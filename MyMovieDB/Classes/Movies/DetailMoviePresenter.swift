//
//  DetailMoviePresenter.swift
//  MyMovieDB
//
//  Created by Fabiola Ramirez on 8/31/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import Foundation

protocol DetailMoviePresenterDelegate {
    func saveMovie(movie: Movie)
    func existMovie(movie: Movie)
    func deleteMovie(movie: Movie)
}

protocol MovieDetailProtocol: AnyObject {
    func movieAlreadyExist()
    func movieCanBeSaved()
    func successfullyMovieDeleted()
}

class DetailMoviePresenter: DetailMoviePresenterDelegate {
    
    weak var view: MovieDetailProtocol?
    
    init(view: MovieDetailProtocol) {
        self.view = view
    }
    
    func saveMovie(movie: Movie) {
        RDatabase.saveMovie(movie)
    }
    
    func existMovie(movie: Movie) {
        if !RDatabase.exist(movie) {
            view?.movieCanBeSaved()
        } else {
            view?.movieAlreadyExist()
        }
    }
    
    func deleteMovie(movie: Movie) {
        RDatabase.deleteMovie(movie)
        view?.successfullyMovieDeleted()
    }

}
