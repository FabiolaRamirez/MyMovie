//
//  Movie.swift
//  MyMovieDB
//
//  Created by Fabiola Ramirez on 8/6/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import Foundation
import RealmSwift
/*class Movie {
    
    var title: String?
    var description: String?
    
    init() {
        title = ""
        description = ""
    }
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
    
}*/

class SearchMovie {
    static let shared = SearchMovie()
    private init() {}
    
    var movieTitles: [String] = []
    var favoriteMovies1: [Movie] = []
    var favoriteMovies2: [Movie] = []
    var favoriteMovies3: [Movie] = []
    var favoriteMovies4: [Movie] = []
    var favoriteMovies5: [Movie] = []
}


struct MoviesResponse: Decodable {
    var Search : [Movie]?
    
}

class Movie: Object, Decodable {
    @objc dynamic var Title: String?
    @objc dynamic var Year: String?
    @objc dynamic var imdbID: String?
    @objc dynamic var Poster: String?
    @objc dynamic var Genre: String?
    @objc dynamic var Plot: String?
    @objc dynamic var imdbRating: String?
    @objc dynamic var Language: String?
    
    override static func primaryKey() -> String? {
        return "imdbID"
    }
}

/*class MovieDetail: Object, Decodable {
    
    @objc dynamic var Title: String?
    @objc dynamic var Year: String?
    @objc dynamic var imdbID: String?
    @objc dynamic var Poster: String?
    @objc dynamic var Genre: String?
    @objc dynamic var Plot: String?
    @objc dynamic var imdbRating: String?
    @objc dynamic var Language: String?
    
    override static func primaryKey() -> String? {
        return "imdbID"
    }
}*/

struct ErrorResponse {
    let message: String?
    init(message: String) {
        self.message = message
    }
}
