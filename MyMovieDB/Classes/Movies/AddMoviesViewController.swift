//
//  AddMoviesViewController.swift
//  MyMovieDB
//
//  Created by Fabiola Ramirez on 8/3/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import UIKit
import Firebase
import SideMenu

protocol AddMoviesPresenterDelegate {
    func searchMovies()
}

class AddMoviesViewController: UIViewController {

    @IBOutlet weak var movieTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var addMoviesPresenter: AddMoviesPresenterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settup()
    }
    
    
    @IBAction func showMenu(_ sender: UIBarButtonItem) {
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
    }
    
    func settup() {
        movieTextField.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        self.navigationItem.title = "Add More Movies".localized
        searchButton.setPrimaryTheme(title: "Search".localized)
        self.addMoviesPresenter = AddMoviesPresenter(view: self)
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
    
    @IBAction func searchMovie(_ sender: UIButton) {
        verifyField()
    }
    
    func verifyField() {
        
        guard let movieName = movieTextField?.text, !movieName.isEmpty else {
            showSimpleAlert(title: "", message: "Please, Enter a movie!".localized)
            return
        }
        cleanData()
        
        if let movieName = movieTextField?.text, !movieName.isEmpty {
            SearchMovie.shared.movieTitles.append(movieName)
        }
        
        searchMovie()
    }
    
    func cleanData() {
        SearchMovie.shared.movieTitles.removeAll()
        SearchMovie.shared.favoriteMovies1.removeAll()
    }
    
    func searchMovie() {
        addMoviesPresenter?.searchMovies()
    }
    
    @objc func dismissKeyboard() {
        hideKeyboard()
    }
    
}

extension AddMoviesViewController: UISideMenuNavigationControllerDelegate {
    
    func sideMenuWillDisappear(menu: UISideMenuNavigationController, animated: Bool) {
        validateAuthentication()
    }
    
}

extension AddMoviesViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        verifyField()
        return false
    }
}

extension AddMoviesViewController: AddMoviesProtocol {
    
    func taskFinished() {
        self.activityIndicator.stopAnimating()
        self.searchButton.isEnabled = true
        let vc: MoviesViewController = UIViewController.instantiateViewController(storyBoard: "Movie", identifier: "moviesViewController") as! MoviesViewController
        vc.simpleSearch = true
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func updateUIWhenTaskstarts() {
        activityIndicator.startAnimating()
        searchButton.isEnabled = false
    }
    
}
