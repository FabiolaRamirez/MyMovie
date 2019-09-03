//
//  DetailMoviePresenter.swift
//  MyMovieDB
//
//  Created by Fabiola Ramirez on 8/31/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import Foundation

protocol MovieDetailProtocol: class {
    func movieAlreadyExist()
    func movieCanBeSaved()
    func successfullyMovieDeleted()
}

class DetailMoviePresenter: DetailMoviePresenterDelegate {
    
    weak var delegate: MovieDetailProtocol?
    
    init(delegate: MovieDetailProtocol) {
        self.delegate = delegate
    }
    
    func saveMovie(movie: Movie) {
        RDatabase.saveMovie(movie)
    }
    
    func existMovie(movie: Movie) {
        if !RDatabase.exist(movie) {
            delegate?.movieCanBeSaved()
        } else {
            delegate?.movieAlreadyExist()
        }
    }
    
    func deleteMovie(movie: Movie) {
        RDatabase.deleteMovie(movie)
        delegate?.successfullyMovieDeleted()
    }

}
