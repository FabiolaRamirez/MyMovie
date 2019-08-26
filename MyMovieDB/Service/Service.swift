//
//  Service.swift
//  MyMovieDB
//
//  Created by Fabiola Ramirez on 8/4/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import Foundation
import Alamofire

class Service {
    
    static let shared = Service()
    
    
    func getMovieBy(title: String, success: @escaping (MoviesResponse) -> Void, error: @escaping (ErrorResponse) -> Void) {
        let url = "\(URLs.BaseUrl)/?apikey=\(ApiValue.ApiKey)&s=\(title)"
        
        Alamofire.request(url).responseData { response in
            if let data = response.result.value {
                do {
                    let dataResponse = try JSONDecoder().decode(MoviesResponse.self, from: data)
                    success(dataResponse)
                } catch {
                    
                }
            } else {
                let errorResponse = ErrorResponse(message: "Something went wrong")
                error(errorResponse)
            }
        }
    }
    
    
    func searchMovies(completionHandler: @escaping () -> Void) {
        
        let movieTitles = SearchMovie.shared.movieTitles
        var count = 0
        let totalCount =  5
        
        if !movieTitles.isEmpty {
            let handler = {
                count = count + 1
                if count >= totalCount {
                    
                    completionHandler()
                }
            }
            getMovieBy(title: movieTitles[0], success: { (response) in
                SearchMovie.shared.favoriteMovies1 = response.Search ?? []
                //print("count movies1: \(response.Search?.count)")
                handler()
            }) { (error) in
                handler()
            }
            
            getMovieBy(title: movieTitles[1], success: { (response) in
                SearchMovie.shared.favoriteMovies2 = response.Search ?? []
                //print("count movies2: \(response.Search?.count)")
                handler()
            }) { (error) in
                handler()
            }
            
            getMovieBy(title: movieTitles[2], success: { (response) in
                SearchMovie.shared.favoriteMovies3 = response.Search ?? []
                //print("count movies3: \(response.Search?.count)")
                handler()
            }) { (error) in
                handler()
            }
            
            getMovieBy(title: movieTitles[3], success: { (response) in
                SearchMovie.shared.favoriteMovies4 = response.Search ?? []
                //print("count movies4: \(response.Search?.count)")
                handler()
            }) { (error) in
                handler()
            }
            
            getMovieBy(title: movieTitles[4], success: { (response) in
                SearchMovie.shared.favoriteMovies5 = response.Search ?? []
                //print("count movies5: \(response.Search?.count)")
                handler()
            }) { (error) in
                handler()
            }
        }
    }
    
    func getDetailOfMovieBy(id: String, success: @escaping (Movie) -> Void, error: @escaping (ErrorResponse) -> Void) {
        let url = "\(URLs.BaseUrl)/?i=\(id)&apikey=\(ApiValue.ApiKey)"
        Alamofire.request(url).responseData { response in
            if let data = response.result.value {
                do {
                    let dataResponse = try JSONDecoder().decode(Movie.self, from: data)
                    success(dataResponse)
                } catch {
                    
                }
            } else {
                let errorResponse = ErrorResponse(message: "ErrorMovieDetail".localized)
                error(errorResponse)
            }
        }
    }
    
}
