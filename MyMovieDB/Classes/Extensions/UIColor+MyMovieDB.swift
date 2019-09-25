//
//  UIColor+MyMovieDB.swift
//  MyMovieDB
//
//  Created by Fabiola Ramirez on 7/23/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    static var orangePrimary: UIColor {
        get{
            return UIColor.init(rgb: 0xffb300)
        }
    }
    
    static var orangeLight: UIColor {
        get{
            return UIColor.init(rgb: 0xffc947)
        }
    }
    
    static var orangeExtraLight: UIColor {
        get{
            return UIColor.init(rgb: 0xfff3e0)
        }
    }
    
    static var orangeDark: UIColor {
        get {
            return UIColor.init(rgb: 0xc66900)
        }
    }
    
    static var greyDark: UIColor {
        get {
            return UIColor.init(rgb: 0x424242)
        }
    }
    
    static var grayRegular: UIColor {
        get {
            return UIColor.init(rgb: 0x616161)
        }
    }
    
    static var grayLight: UIColor {
        get {
            return UIColor.init(rgb: 0x9e9e9e)
        }
    }
    
    static var lightGrayBackgroundColor: UIColor {
        get {
            return UIColor.init(rgb: 0xF8F8F8)
        }
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red")
        assert(green >= 0 && green <= 255, "Invalid green")
        assert(blue >= 0 && blue <= 255, "Invalid blue")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
}
