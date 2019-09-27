//
//  Database.swift
//  MyMovieDB
//
//  Created by Fabiola Ramirez on 8/17/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import Foundation
import RealmSwift


class RDatabase {
    
    static func saveMovie(_ movie: Movie) {
        let realm = try! Realm()
        if realm.object(ofType: Movie.self, forPrimaryKey: movie.imdbID) != nil {
            return
        }
        try! realm.write {
            realm.add(movie)
        }
    }
    
    static func deleteMovie(_ movie: Movie) {
        let realm = try! Realm()
        if let m = realm.object(ofType: Movie.self, forPrimaryKey: movie.imdbID) {
            try! realm.write {
                realm.delete(m)
            }
        }
    }
    
    
    static func fetchMovies() -> [Movie] {
        let realm = try! Realm()
        let movies = realm.objects(Movie.self)
        return Array(movies)
    }
    
    static func exist(_ movie: Movie) -> Bool {
        let realm = try! Realm()
        if realm.object(ofType: Movie.self, forPrimaryKey: movie.imdbID) != nil {
            return true
        } else {
            return false
        }
    }
    
    static func cleanAllData() {
        // Delete all objects from the realm
        let realm = try! Realm()
        try! realm.write {
            realm.delete(realm.objects(Movie.self))
        }
    }

    
}
