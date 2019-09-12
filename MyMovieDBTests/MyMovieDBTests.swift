//
//  MyMovieDBTests.swift
//  MyMovieDBTests
//
//  Created by Fabiola Ramirez on 9/11/19.
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

    func testSearchSimpleMovie() {
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

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
