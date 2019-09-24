//
//  NavigationUITests.swift
//  MyMovieUITests
//
//  Created by Fabiola Ramirez on 9/22/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import XCTest

class NavigationUITests: BaseStepsTests {
    
    func testAddMoreMovies() {
        logIn(email: "test222@algo.com", password: "Password123")
        validateHomeScreen()
        openMenu()
        openAddMoreMovies()
        validateScreenName(screenName: addMoreMoviesPageName)
    }
    

}
