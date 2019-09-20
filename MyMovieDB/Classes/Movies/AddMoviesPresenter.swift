//
//  AddMoviesPresenter.swift
//  MyMovieDB
//
//  Created by Fabiola Ramirez on 9/3/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import Foundation


// TODO: Why class and not AnyObject?
protocol AddMoviesProtocol: class {
    func taskFinished()
    func updateUIWhenTaskstarts()
}

class AddMoviesPresenter: AddMoviesPresenterDelegate {
    
    
    //TODO: we actually changed this to the right name according to the pattern. It should be view...not delegate
    weak var delegate: AddMoviesProtocol?
    
    init(delegate: AddMoviesProtocol) {
        self.delegate = delegate
    }
    
    func searchMovies() {
        delegate?.updateUIWhenTaskstarts()
        Service.shared.getMoviesOneSearch {
            self.delegate?.taskFinished()
        }
    }
    
}
