//
//  UIBarButtonItem+MyMovieDB.swift
//  MyMovieDB
//
//  Created by Fabiola Ramirez on 9/29/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import Foundation
import UIKit


extension UIBarButtonItem {
    
    func isHidden(_ hidden: Bool)  {
        if hidden {
            tintColor = UIColor.clear
            isEnabled = false
        } else {
            tintColor = UIColor.orangePrimary
            isEnabled = true
        }
    }
}
