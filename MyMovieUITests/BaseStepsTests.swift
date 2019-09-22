//
//  BaseStepsTests.swift
//  MyMovieDBUITests
//
//  Created by Fabiola Ramirez on 9/22/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import XCTest

class BaseStepsTests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = true

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        app = XCUIApplication()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func logIn(email: String, password: String) {
        
        //email
        //let emailTextField = app.otherElements[AccessibilityContants.emailTextFieldId]
        
        let predicate = NSPredicate(format: "identifier CONTAINS[c] '\(AccessibilityContants.emailTextFieldId)'")
        let elements = app.otherElements.containing(predicate)
        let elementFactorLabel = elements.allElementsBoundByIndex[0]
        XCTAssert(elementFactorLabel.exists, "\(name) not found")
        
        elementFactorLabel.tap()
        elementFactorLabel.clearAndEnterText(text: email)
        
        let passwordTextField = app.secureTextFields[AccessibilityContants.passwordTextField]
        passwordTextField.tap()
        passwordTextField.clearAndEnterText(text: password)
        
        app.buttons["Log In"].tap()
        
        
        
    }

}
