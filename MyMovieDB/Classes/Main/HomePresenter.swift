//
//  HomePresenter.swift
//  MyMovieDB
//
//  Created by Fabiola Ramirez on 9/3/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import Foundation


protocol HomeProtocol: class {
    func taskFinished()
    func updateUIWhenTaskstarts()
}

class HomePresenter: HomePresenterDelegate {
    
    weak var delegate: HomeProtocol?
    
    init(delegate: HomeProtocol) {
        self.delegate = delegate
    }
    
    func searchMovies() {
        delegate?.updateUIWhenTaskstarts()
        Service.shared.searchMovies {
            self.delegate?.taskFinished()
        }
    }
    
}
