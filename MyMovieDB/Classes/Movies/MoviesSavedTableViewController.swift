//
//  MoviesSavedTableViewController.swift
//  MyMovieDB
//
//  Created by Fabiola Ramirez on 8/21/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import UIKit
import Firebase
import FAPanels

class MoviesSavedTableViewController: UITableViewController {

    let cellIdentifier = "movieSavedCell"
    var movies: [Movie] = []
    var moviesSavedPresenter: MoviesSavedPresenterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: "MovieSavedCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.moviesSavedPresenter = MoviesSavedPresenter(view: self)
        tableView.backgroundColor = .lightGrayBackgroundColor

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
    }
    
    func setup() {
        loadMovies()
        self.tableView.reloadData()
    }
    
    func loadMovies() {
        movies = moviesSavedPresenter?.getMovies() ?? []
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

extension MoviesSavedTableViewController: MovieSavedProtocol {
    func successfullyMovieDeleted() {
        print("successfully Deleted!")
    }
    
    
}



