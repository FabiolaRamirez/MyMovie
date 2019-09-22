//
//  Extensions.swift
//  MyMovieUITests
//
//  Created by Fabiola Ramirez on 9/22/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import Foundation
import XCTest


extension XCUIElement {
    
    
    func clearAndEnterText(text: String) {
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }
        
        self.tap()
        
        let deleteString = stringValue.map { _ in XCUIKeyboardKey.delete.rawValue }.joined(separator: "")
        
        self.typeText(deleteString)
        self.typeText(text)
    }
    
}
