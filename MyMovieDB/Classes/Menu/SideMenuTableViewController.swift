//
//  SideMenuTableViewController.swift
//  MyMovieDB
//
//  Created by Fabiola Ramirez on 8/2/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import SideMenu

class SideMenuTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private let menuCellIdentifier = "menuCellIdentifier"
    
    enum SideMenuOption: Int {
        case home = 0
        case addMoreMovies
        case logOut
        
        var name: String {
            switch self {
            case .home:
                return "Home".localized
            case .addMoreMovies:
                return "Add More Movies".localized
            case .logOut:
                return "Log Out".localized
            }
        }
        
        static var all: [SideMenuOption] {
            return [.home, .addMoreMovies, .logOut]
        }
    }
    
    override func viewDidLoad() {
        super .viewDidLoad()
        tableView.backgroundColor = .white
        
        #if DEV
        print("It is dev!")
        #elseif STAGE
        print("It is stage!")
        #elseif PROD
        print("It is prod!")
        #endif
    }
    
    func showHome() {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        if RDatabase.fetchMovies().count > 0 {
            let vc  = UIViewController.instantiateViewController(storyBoard: "Movie", identifier: "moviesSavedTableViewController") as! MoviesSavedTableViewController
            navigationController?.pushViewController(vc, animated: false)
        } else {
            let vc  = UIViewController.instantiateViewController(storyBoard: "Main", identifier: "homeTableViewController") as! HomeTableViewController
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    func showAddMoreMovies() {
        let vc: AddMoviesViewController = UIViewController.instantiateViewController(storyBoard: "Movie", identifier: "addMoviesViewController") as! AddMoviesViewController
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func logout() {
        
        let alert = UIAlertController(title: "Log Out".localized, message: "LogOutMessage".localized, preferredStyle: .alert)
        let action = UIAlertAction(title: "Yes".localized, style: .default) { (action2) in
            do {
                try Auth.auth().signOut()
                self.presentingViewController?.dismiss(animated: true, completion: nil)
            } catch let error {
                self.showSimpleAlert(title: "", message: "ErrorLogoutMessage".localized)
                print("Failed to sign out: \(error.localizedDescription)")
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel".localized, style: .cancel) { (action) in }
        alert.addAction(cancel)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
}


extension SideMenuTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SideMenuOption.all.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let option = SideMenuOption(rawValue: indexPath.row) ?? .home
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: menuCellIdentifier) {
            cell.textLabel?.text = option.name
            
            return cell
        }
        
        
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let option = SideMenuOption(rawValue: indexPath.row) ?? .home
        switch option {
        case .home:
            showHome()
        case .addMoreMovies:
            showAddMoreMovies()
        case .logOut:
            logout()
        }
    }
    
    
    
    
}
