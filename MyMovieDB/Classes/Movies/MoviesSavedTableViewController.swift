//
//  MoviesSavedTableViewController.swift
//  MyMovieDB
//
//  Created by Fabiola Ramirez on 8/21/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import UIKit
import Firebase
import SideMenu

protocol MoviesSavedPresenterDelegate {
    func deleteMovie(movie: Movie)
    func getMovies() -> [Movie]
}

class MoviesSavedTableViewController: UITableViewController {

    let cellIdentifier = "movieSavedCell"
    var movies: [Movie] = []
    var moviesSavedPresenter: MoviesSavedPresenterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: "MovieSavedCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.navigationItem.title = "Home".localized
        settingMenu()
        self.moviesSavedPresenter = MoviesSavedPresenter(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadMovies()
        self.tableView.reloadData()
    }
    
    func loadMovies() {
        movies = moviesSavedPresenter?.getMovies() ?? []
    }
    
    @IBAction func searchMovies(_ sender: UIBarButtonItem) {

        let vc  = UIViewController.instantiateViewController(storyBoard: "Main", identifier: "homeTableViewController") as! HomeTableViewController
        navigationController?.pushViewController(vc, animated: false)
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
    
    // MARK: - Menu Side
    
    @IBAction func showMenu(_ sender: UIBarButtonItem) {
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
    }
    
    func settingMenu() {
        let vc: SideMenuTableViewController = UIViewController.instantiateViewController(storyBoard: "Menu", identifier: "sideMenuTableViewController") as! SideMenuTableViewController
        let sideMenu = UISideMenuNavigationController(rootViewController: vc)
        sideMenu.sideMenuDelegate = self
        sideMenu.setNavigationBarHidden(true, animated: false)
        SideMenuManager.defaultManager.menuLeftNavigationController = sideMenu
        SideMenuManager.defaultManager.menuPresentMode = .menuSlideIn
        SideMenuManager.defaultManager.menuWidth = 180
        SideMenuManager.defaultManager.menuAnimationBackgroundColor = UIColor.lightGrayBackgroundColor
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MovieSavedCell
        let movie = movies[indexPath.row]
        cell.initWithData(movie)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
         let movieId = movies[indexPath.row].imdbID!
         showMovieDetail(movieId: movieId)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let movie: Movie = movies[indexPath.row]
            deleteMovie(movie)
            loadMovies()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func showMovieDetail(movieId: String) {
        let vc: DetailViewController = UIViewController.instantiateViewController(storyBoard: "Movie", identifier: "detailViewController") as! DetailViewController
        vc.movieId = movieId
        vc.isItemForDeletingState = true
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    // MARK: Methods for Database
    
    func deleteMovie(_ movie: Movie) {
        self.moviesSavedPresenter?.deleteMovie(movie: movie)
    }
    

}

extension MoviesSavedTableViewController: UISideMenuNavigationControllerDelegate {
    
    func sideMenuWillDisappear(menu: UISideMenuNavigationController, animated: Bool) {
        validateAuthentication()
    }
    
}

extension MoviesSavedTableViewController: MovieSavedProtocol {
    func successfullyMovieDeleted() {
        print("successfully Deleted!")
    }
    
    
}



