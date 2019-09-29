//
//  HomeTableViewController.swift
//  MyMovieDB
//
//  Created by Fabiola Ramirez on 8/25/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import UIKit
import Firebase
import Crashlytics

class HomeTableViewController: UITableViewController {
    
    @IBOutlet weak var movieTextField1: UITextField!
    @IBOutlet weak var movieTextField2: UITextField!
    @IBOutlet weak var movieTextField3: UITextField!
    @IBOutlet weak var movieTextField4: UITextField!
    @IBOutlet weak var movieTextField5: UITextField!
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var homePresenter: HomePresenterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settup()
    }
    
    func validateAuthentication() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let vc: LoginViewController = UIViewController.instantiateViewController(storyBoard: "User", identifier: "loginViewController") as! LoginViewController
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    func settup() {
        movieTextField1.delegate = self
        movieTextField2.delegate = self
        movieTextField3.delegate = self
        movieTextField4.delegate = self
        movieTextField5.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        self.homePresenter = HomePresenter(view: self)
        view.backgroundColor = .lightGrayBackgroundColor
        searchButton.setPrimaryTheme(title: "Search".localized)
    }
    
    @objc func dismissKeyboard() {
        hideKeyboard()
    }
    
    @IBAction func searchMovies(_ sender: UIButton) {
        verifyFields()
    }
    
    func verifyFields() {
        
        guard let movie1 = movieTextField1?.text, !movie1.isEmpty, let movie2 = movieTextField2?.text, !movie2.isEmpty, let movie3 = movieTextField3?.text, !movie3.isEmpty, let movie4 = movieTextField4?.text, !movie4.isEmpty, let movie5 = movieTextField5?.text, !movie5.isEmpty else {
            showSimpleAlert(title: "", message: "Please, Enter five movies!".localized)
            return
        }
        SearchMovie.shared.cleanData()
        
        if let movieName = movieTextField1?.text, !movieName.isEmpty {
            SearchMovie.shared.movieTitles.append(movieName)
        }
        if let movieName = movieTextField2?.text, !movieName.isEmpty {
            SearchMovie.shared.movieTitles.append(movieName)
        }
        if let movieName = movieTextField3?.text, !movieName.isEmpty {
            SearchMovie.shared.movieTitles.append(movieName)
        }
        if let movieName = movieTextField4?.text, !movieName.isEmpty {
            SearchMovie.shared.movieTitles.append(movieName)
        }
        if let movieName = movieTextField5?.text, !movieName.isEmpty {
            SearchMovie.shared.movieTitles.append(movieName)
        }
        
        searchMovies()
    }
    
    func searchMovies() {
        homePresenter?.searchMovies()
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
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.backgroundColor = .lightGrayBackgroundColor
    }
}


extension HomeTableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return false
    }
}

extension HomeTableViewController: HomeProtocol {
    
    func taskFinished() {
        self.activityIndicator.stopAnimating()
        self.searchButton.isEnabled = true
        let vc: MoviesViewController = UIViewController.instantiateViewController(storyBoard: "Movie", identifier: "moviesViewController") as! MoviesViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func updateUIWhenTaskstarts() {
        activityIndicator.startAnimating()
        searchButton.isEnabled = false
    }
    
}


