//
//  UIFont+MyMovieDB.swift
//  MyMovieDB
//
//  Created by Fabiola Ramirez on 7/23/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    class func neueBold(_ size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Bold", size: size)!
    }
    
    class func neueRegular(_ size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue", size: size)!
    }
    
    class func neueMedium(_ size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Medium", size: size)!
    }
    
    class func neueLight(_ size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Light", size: size)!
    }
    
}
