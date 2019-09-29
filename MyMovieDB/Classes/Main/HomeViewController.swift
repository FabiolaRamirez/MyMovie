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
    
    var homePresenter: HomePresenterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homePresenter = HomePresenter(view: self)
        initView()
        homePresenter?.stateDidChangeListener()
    }
    
    func initView() {
        homePresenter?.verifyIfUserIsAuth()
    }
    
    @IBAction func showMenu(_ sender: UIBarButtonItem) {
        panel?.openLeft(animated: true)
    }
    
    @IBAction func searchMovies(_ sender: UIBarButtonItem) {
        searchMovie()
    }
    
    func searchMovie() {
        self.navigationItem.title = "Search Movies".localized
        searchButton.isHidden(true)
        let vc = UIViewController.instantiateViewController(storyBoard: "Main", identifier: "searchMoviesTableViewController") as! SearchMoviesTableViewController
        add(vc)
    }

}

extension HomeViewController: HomeProtocol {
    
    func userIsAuth() {
        homePresenter?.verifyListOfMovies()
    }
    
    func userNoAuth() {
        let vc: LoginViewController = UIViewController.instantiateViewController(storyBoard: "User", identifier: "loginViewController") as! LoginViewController
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func refreshViews() {
         self.initView()
    }
    
    func listOfMoviesIsEmpty() {
        self.navigationItem.title = "Search Movies".localized
        searchButton.isHidden(true)
        let vc  = UIViewController.instantiateViewController(storyBoard: "Main", identifier: "searchMoviesTableViewController") as! SearchMoviesTableViewController
        add(vc)
    }
    
    func listOfMoviesNoEmpty() {
        self.navigationItem.title = "Home".localized
        searchButton.isHidden(false)
        let vc = UIViewController.instantiateViewController(storyBoard: "Movie", identifier: "moviesSavedTableViewController") as! MoviesSavedTableViewController
        add(vc)
    }
    
}
