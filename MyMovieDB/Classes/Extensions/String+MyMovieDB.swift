//
//  String+MyMovieDB.swift
//  MyMovieDB
//
//  Created by Fabiola Ramirez on 8/4/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import Foundation


extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
