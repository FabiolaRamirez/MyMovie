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

class SideMenuTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private let menuCellIdentifier = "menuCellIdentifier"
    @IBOutlet weak var versionLabel: UILabel!
    
    var sideMenuPresenter: SideMenuPresenterDelegate?
    
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
        settup()
    }
    
    func settup() {
        self.sideMenuPresenter = SideMenuPresenter(view: self)
        view.backgroundColor = .lightGrayBackgroundColor
        tableView.backgroundColor = .lightGrayBackgroundColor
        versionLabel.isHidden = true
        #if DEV
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0"
        let appBuild = Bundle.main.infoDictionary?[kCFBundleVersionKey as String] as? String ?? "0"
        versionLabel.text = "Version: v\(appVersion) (\(appBuild))"
        versionLabel.isHidden = false
        #endif
    }
    
    func showHome() {
        let vc  = UIViewController.instantiateViewController(storyBoard: "Main", identifier: "homeViewController") as! HomeViewController
        let navigationController = UINavigationController(rootViewController: vc)
        panel?.center(navigationController)
    }
    
    func showAddMoreMovies() {
        let vc: AddMoviesViewController = UIViewController.instantiateViewController(storyBoard: "Movie", identifier: "addMoviesViewController") as! AddMoviesViewController
        let navigationController = UINavigationController(rootViewController: vc)
        panel?.center(navigationController)
    }
    
    func logout() {
        
        let alert = UIAlertController(title: "Log Out".localized, message: "LogOutMessage".localized, preferredStyle: .alert)
        let action = UIAlertAction(title: "Yes".localized, style: .default) { (action2) in
            self.sideMenuPresenter?.logOut()
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
            cell.contentView.backgroundColor = .lightGrayBackgroundColor
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


extension SideMenuTableViewController: SideMenuProtocol {
    
    func logOutSuccessful() {
        RDatabase.cleanAllData()
        self.panel?.closeLeft()
        let vc: LoginViewController = UIViewController.instantiateViewController(storyBoard: "User", identifier: "loginViewController") as! LoginViewController
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func logOutUnsuccessful(message: String) {
        self.showSimpleAlert(title: "", message: message)
    }
    
    
    
}
