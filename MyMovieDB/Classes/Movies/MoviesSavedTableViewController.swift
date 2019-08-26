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


class MoviesSavedTableViewController: UITableViewController {

    let cellIdentifier = "movieSavedCell"
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: "MovieSavedCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.navigationItem.title = "Home".localized
        loadMovies()
        settingMenu()
    }
    
    func loadMovies() {
        movies = RDatabase.fetchMovies()
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
        
        
    }

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let movie: Movie = movies[indexPath.row]
            deleteMovie(movie)
            loadMovies()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: Methods for Database
    
    func deleteMovie(_ movie: Movie) {
        RDatabase.deleteMovie(movie)
    }
    

}

extension MoviesSavedTableViewController: UISideMenuNavigationControllerDelegate {
    
    func sideMenuWillDisappear(menu: UISideMenuNavigationController, animated: Bool) {
        validateAuthentication()
    }
    
}
