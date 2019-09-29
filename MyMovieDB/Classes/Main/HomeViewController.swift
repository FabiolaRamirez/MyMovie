//
//  HomeViewController.swift
//  MyMovieDB
//
//  Created by Fabiola Ramirez on 9/29/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var searchButton: UIBarButtonItem!
    
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        Auth.auth().addStateDidChangeListener { (auth, user) in
            self.initView()
        }
    }
    
    func initView() {
        guard let _ = Auth.auth().currentUser else {
            let vc: LoginViewController = UIViewController.instantiateViewController(storyBoard: "User", identifier: "loginViewController") as! LoginViewController
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: true, completion: nil)
            return
        }
        
        movies = RDatabase.fetchMovies()
        if movies.isEmpty {
            self.navigationItem.title = "Search Movies".localized
            searchButton.isHidden(true)
            let vc  = UIViewController.instantiateViewController(storyBoard: "Main", identifier: "searchMoviesTableViewController") as! SearchMoviesTableViewController
            add(vc)
        } else {
            self.navigationItem.title = "Home".localized
            searchButton.isHidden(false)
            let vc = UIViewController.instantiateViewController(storyBoard: "Movie", identifier: "moviesSavedTableViewController") as! MoviesSavedTableViewController
            add(vc)
        }
    }
    
    @IBAction func showMenu(_ sender: UIBarButtonItem) {
        panel?.openLeft(animated: true)
    }
    
    @IBAction func searchMovies(_ sender: UIBarButtonItem) {
        showAndHideViews()
    }
    
    func showAndHideViews() {
        self.navigationItem.title = "Search Movies".localized
        searchButton.isHidden(true)
        let vc = UIViewController.instantiateViewController(storyBoard: "Main", identifier: "searchMoviesTableViewController") as! SearchMoviesTableViewController
        add(vc)
    }

}
