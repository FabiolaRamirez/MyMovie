//
//  LogInUITests.swift
//  MyMovieDBUITests
//
//  Created by Fabiola Ramirez on 9/22/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import XCTest

class LogInUITests: BaseStepsTests {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLogin() {
        //print("debug descrip: \(app.debugDescription)")
        //logIn(email: "test720@cs.com", password: "Password1")
        //checkHomeScreen()
        
        
        let app = XCUIApplication()
        //let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element
        //element.tap()
        //element.tap()
        app/*@START_MENU_TOKEN@*/.textFields["emailTextFieldId"]/*[[".textFields[\"Enter email\"]",".textFields[\"emailTextFieldId\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.secureTextFields["passwordTextFieldId"]/*[[".secureTextFields[\"Enter password\"]",".secureTextFields[\"passwordTextFieldId\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Log In"].tap()
        
                                        
    }

}
