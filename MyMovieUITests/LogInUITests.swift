//
//  LogInUITests.swift
//  MyMovieDBUITests
//
//  Created by Fabiola Ramirez on 9/22/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import XCTest

class LogInUITests: BaseStepsTests {

    
    func testLogin() {
        //print("debug descrip: \(app.debugDescription)")
        logIn(email: "test111@algo.com", password: "Password123")
        validateHomeScreen()
    }

}
