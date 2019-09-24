//
//  MyMovieDBTests.swift
//  MyMovieDBTests
//
//  Created by Fabiola Ramirez on 9/5/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import XCTest
@testable import MyMovieDB

class MyMovieDBTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSearchMovie() {
        let movieName = "matrix"
        var movies: [Movie] = []
        let expectation = XCTestExpectation(description: "Search movies by title")
        Service.shared.getMoviesBy(title: movieName, success: { (response) in
            if let moviesList = response.Search {
                movies = moviesList
            } else {
                XCTFail()
            }
            expectation.fulfill()
        }) { (error) in
            XCTFail()
        }
        wait(for: [expectation], timeout: 15.0)
        XCTAssertEqual(movies.count, 10)
    }
    
    func testSearchById() {
        let endGameIdMovie = "tt0415778"
        var movie: Movie?
        let expectation = XCTestExpectation(description: "Search movies by Id")
        Service.shared.getDetailOfMovieBy(id: endGameIdMovie, success: { (response) in
             movie = response
            expectation.fulfill()
        }) { (error) in
            XCTFail()
        }
        wait(for: [expectation], timeout: 15.0)
        XCTAssertEqual(movie?.Title, "End Game")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testBaseUrl() {
        XCTAssertEqual(URLs.BaseUrl, "https://www.omdbapi.com")
    }

}
