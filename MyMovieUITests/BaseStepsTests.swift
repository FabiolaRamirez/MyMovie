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

    
    let exists = NSPredicate(format: "exists == 1")
    let addMoreMoviesPageName = "Add More Movies"
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = true

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        logout()
    }
    
    func logIn(email: String, password: String) {
        
        //email
        let emailTextField = app.textFields[AccessibilityContants.emailTextFieldId]
        emailTextField.tap()
        emailTextField.clearAndEnterText(text: email)
        
        //password
        let passwordTextField = app.secureTextFields[AccessibilityContants.passwordTextField]
        passwordTextField.tap()
        passwordTextField.clearAndEnterText(text: password)
    
        app.buttons[AccessibilityContants.logInButtonId].tap()
        
    }
    
    func signUp(email: String, password: String) {
        let signUpButton = app.buttons["Sign Up"]
        if signUpButton.exists {
            signUpButton.tap()
        }
        
        //email
        let emailTextField = app.textFields[AccessibilityContants.emailSignUpTextFieldId]
        emailTextField.tap()
        emailTextField.clearAndEnterText(text: email)
        
        //password
        let passwordTextField = app.textFields[AccessibilityContants.passwordSignUpTextFieldId]
        passwordTextField.tap()
        passwordTextField.clearAndEnterText(text: password)
        
        app.buttons[AccessibilityContants.signUpButtonId].tap()
        
    }
    
    func logout() {
        sleep(1)
        let menuButton = app.navigationBars["Home"].buttons["Menu"]
        if menuButton.exists {
            menuButton.tap()
        }
        let menuElement = app.navigationBars["Add More Movies"].buttons["Menu"]
        if menuElement.exists {
            menuElement.tap()
        }
        
        let logOutElement = app.tables.staticTexts["Log Out"]
        if logOutElement.exists {
            logOutElement.tap()
            app.alerts["Log Out"].buttons["Yes"].tap()
        } else {
            XCTFail("'Add More Movies' text not found")
        }
        
    }
    
    func resetNavigation() {
        var backButton = app.buttons["Back"]
        while backButton.exists {
            backButton.tap()
            backButton = app.buttons["Back"]
        }
    }
    
    func openMenu() {
        let menuButton = app.navigationBars["Home"].buttons["Menu"]
        expectation(for: exists, evaluatedWith: menuButton, handler: nil)
        waitForExpectations(timeout: 30, handler: nil)
        if menuButton.exists {
            menuButton.tap()
        } else {
            XCTFail("Menu button not found")
        }
    }
    
    func openAddMoreMovies() {
        let addMoreMoviesElement = app.tables.staticTexts["Add More Movies"]
        if addMoreMoviesElement.exists {
            addMoreMoviesElement.tap()
        } else {
            XCTFail("'Add More Movies' text not found")
        }
    }
    
    func openMovieWith(title: String) {
        let titleMovieElement = app.tables.staticTexts[title]
        if titleMovieElement.exists {
            titleMovieElement.tap()
        } else {
            XCTFail("Movie with title: \(title) no found")
        }
    }
    
    
    //MARK:- Validation
    
    func validateHomeScreen() {
        let menuButton = app.navigationBars["Home"].buttons["Menu"]
        expectation(for: exists, evaluatedWith: menuButton, handler: nil)
        waitForExpectations(timeout: 30, handler: nil)
        XCTAssert(menuButton.exists, "Unable to see Home screen!")
    }
    
    /*func validateOpenAddMoreMovies() {
        let vv = app.navigationBars["Add More Movies"].otherElements["Add More Movies"]
    }*/
    
    func validateScreenName(screenName: String) {
        let staticText = app.staticTexts[screenName]
        expectation(for: exists, evaluatedWith: staticText, handler: nil)
        waitForExpectations(timeout: 30, handler: nil)
        let pageTitle = app.staticTexts.element(matching: .any, identifier: screenName).label
        
        XCTAssertEqual(screenName, pageTitle)
    }
    
    func validateMovieDetail(movieTitle: String) {
        let pageTitle = app.navigationBars[movieTitle]
        expectation(for: exists, evaluatedWith: pageTitle, handler: nil)
        waitForExpectations(timeout: 30, handler: nil)
        XCTAssert(pageTitle.exists, "Unable to see detail screen of \(movieTitle)!")
    }

}
