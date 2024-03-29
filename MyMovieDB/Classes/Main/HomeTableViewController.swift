//
//  HomeTableViewController.swift
//  MyMovieDB
//
//  Created by Fabiola Ramirez on 8/25/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import UIKit
import Firebase
import SideMenu


class HomeTableViewController: UITableViewController {
    
    @IBOutlet weak var movieTextField1: UITextField!
    @IBOutlet weak var movieTextField2: UITextField!
    @IBOutlet weak var movieTextField3: UITextField!
    @IBOutlet weak var movieTextField4: UITextField!
    @IBOutlet weak var movieTextField5: UITextField!
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        validateAuthentication()
        configMenu()
        settup()
    }
    
    func validateAuthentication() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let vc: LoginViewController = UIViewController.instantiateViewController(storyBoard: "User", identifier: "loginViewController") as! LoginViewController
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    func configMenu() {
        let vc: SideMenuTableViewController = UIViewController.instantiateViewController(storyBoard: "Menu", identifier: "sideMenuTableViewController") as! SideMenuTableViewController
        let sideMenu = UISideMenuNavigationController(rootViewController: vc)
        sideMenu.sideMenuDelegate = self
        sideMenu.setNavigationBarHidden(true, animated: false)
        SideMenuManager.defaultManager.menuLeftNavigationController = sideMenu
        SideMenuManager.defaultManager.menuPresentMode = .menuSlideIn
        SideMenuManager.defaultManager.menuWidth = 180
        SideMenuManager.defaultManager.menuAnimationBackgroundColor = UIColor.lightGrayBackgroundColor
    }
    
    func settup() {
        movieTextField1.delegate = self
        movieTextField2.delegate = self
        movieTextField3.delegate = self
        movieTextField4.delegate = self
        movieTextField5.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        self.navigationItem.title = "Home".localized
        
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func showMenu(_ sender: UIBarButtonItem) {
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
    }
    
    @IBAction func searchMovies(_ sender: UIButton) {
        verifyFields()
    }
    
    func verifyFields() {
        
        guard let movie1 = movieTextField1?.text, !movie1.isEmpty, let movie2 = movieTextField2?.text, !movie2.isEmpty, let movie3 = movieTextField3?.text, !movie3.isEmpty, let movie4 = movieTextField4?.text, !movie4.isEmpty, let movie5 = movieTextField5?.text, !movie5.isEmpty else {
            showSimpleAlert(title: "", message: "Please, Enter your favorite movies!".localized)
            return
        }
        cleanData()
        
        if let movie = movieTextField1?.text, !movie.isEmpty {
            SearchMovie.shared.movieTitles.append(movie)
        }
        if let movie = movieTextField2?.text, !movie.isEmpty {
            SearchMovie.shared.movieTitles.append(movie)
        }
        if let movie = movieTextField3?.text, !movie.isEmpty {
            SearchMovie.shared.movieTitles.append(movie)
        }
        if let movie = movieTextField4?.text, !movie.isEmpty {
            SearchMovie.shared.movieTitles.append(movie)
        }
        if let movie = movieTextField5?.text, !movie.isEmpty {
            SearchMovie.shared.movieTitles.append(movie)
        }
        
        searchMovies()
    }
    
    func cleanData() {
        SearchMovie.shared.movieTitles.removeAll()
        SearchMovie.shared.favoriteMovies1.removeAll()
        SearchMovie.shared.favoriteMovies2.removeAll()
        SearchMovie.shared.favoriteMovies3.removeAll()
        SearchMovie.shared.favoriteMovies4.removeAll()
        SearchMovie.shared.favoriteMovies4.removeAll()
    }
    
    func searchMovies() {
        activityIndicator.startAnimating()
        searchButton.isEnabled = false
        Service.shared.searchMovies {
            self.activityIndicator.stopAnimating()
            self.searchButton.isEnabled = true
            let vc: MoviesViewController = UIViewController.instantiateViewController(storyBoard: "Movie", identifier: "moviesViewController") as! MoviesViewController
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 5
        } else {
            return 1
        }
        
    }
    
    
}

extension HomeTableViewController: UISideMenuNavigationControllerDelegate {
    
    func sideMenuWillDisappear(menu: UISideMenuNavigationController, animated: Bool) {
        validateAuthentication()
    }
    
}

extension HomeTableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return false
    }
}

