//
//  SignUpUITests.swift
//  MyMovieUITests
//
//  Created by Fabiola Ramirez on 9/22/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import XCTest

class SignUpUITests: BaseStepsTests {


    func testSignUp() {
        signUp(email: "test131@algo.com", password: "Password123")
        validateHomeScreen()
    }

}
