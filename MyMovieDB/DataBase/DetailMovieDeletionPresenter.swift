//
//  DetailMovieDeletionPresenter.swift
//  MyMovieDB
//
//  Created by Fabiola Ramirez on 9/1/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import Foundation

protocol MovieDeletedProtocol: class {
    func successfullyMovieDeleted()
}

class DetailMovieDeletionPresenter: DetailMovieDeletionPresenterDelegate {
    

    weak var delegate: MovieDeletedProtocol?
    
    init(delegate: MovieDeletedProtocol) {
        self.delegate = delegate
    }
    
    func deleteMovie(movie: Movie) {
        RDatabase.deleteMovie(movie)
        delegate?.successfullyMovieDeleted()
    }
    
}
