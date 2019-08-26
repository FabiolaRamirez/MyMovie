//
//  UIButton+MyMovieDB.swift
//  MyMovieDB
//
//  Created by Fabiola Ramirez on 7/25/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {

    func setPrimaryTheme(title: String) {
        backgroundColor = UIColor.orangePrimary
        setTitle(title, for: .normal)
        setTitleColor(UIColor.white, for: .normal)
        titleLabel?.font = UIFont.neueBold(14)
        layer.cornerRadius = 22
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1
    }
    
    func setSecondTheme(title: String) {
        backgroundColor = UIColor.white
        setTitle(title, for: .normal)
        setTitleColor(UIColor.orangePrimary, for: .normal)
        titleLabel?.font = UIFont.neueBold(14)
        layer.cornerRadius = 22
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1
    }
    

}


