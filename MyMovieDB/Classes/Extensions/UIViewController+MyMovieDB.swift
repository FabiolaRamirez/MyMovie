//
//  UIViewController+MyMovieDB.swift
//  MyMovieDB
//
//  Created by Fabiola Ramirez on 8/3/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    class func instantiateViewController(storyBoard: String, identifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: storyBoard, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier :identifier)
        return viewController
    }
    
    func showSimpleAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Ok".localized, style: .cancel) { (action) in
        }
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    func hideKeyboard() {
        view.endEditing(true)
    }
    
}
