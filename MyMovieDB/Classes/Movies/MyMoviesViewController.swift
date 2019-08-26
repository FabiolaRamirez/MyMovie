//
//  MyMoviesViewController.swift
//  MyMovieDB
//
//  Created by Fabiola Ramirez on 8/3/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import UIKit
import Firebase
import SideMenu

class MyMoviesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "My Movies".localized
    }

    @IBAction func showMenu(_ sender: UIBarButtonItem) {
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
    }
    
    // MARK: - Validations
    
    func validateAuthentication() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let vc: LoginViewController = UIViewController.instantiateViewController(storyBoard: "User", identifier: "loginViewController") as! LoginViewController
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    
}

extension MyMoviesViewController: UISideMenuNavigationControllerDelegate {
    
    func sideMenuWillDisappear(menu: UISideMenuNavigationController, animated: Bool) {
        validateAuthentication()
    }
    
}
