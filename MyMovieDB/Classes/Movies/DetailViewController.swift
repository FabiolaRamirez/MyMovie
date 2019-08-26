//
//  DetailViewController.swift
//  MyMovieDB
//
//  Created by Fabiola Ramirez on 8/6/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let cellIdentifier = "movieDetailCell"
    var movieId: String?
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        tableView.register(UINib.init(nibName: "MovieDetailCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    func setData() {
        self.navigationItem.title = movie?.Title ?? ""
        tableView.reloadData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDetailBy(movieId: movieId!)
    }
    
    func getDetailBy(movieId: String) {
        activityIndicator.startAnimating()
        Service.shared.getDetailOfMovieBy(id: movieId, success: { (response) in
            self.activityIndicator.stopAnimating()
            if response != nil {
                self.movie = response
                self.setData()
            }
        }) { (error) in
            self.showSimpleAlert(title: "", message: error.message!)
        }
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "", message: "SaveMessage".localized, preferredStyle: .alert)
        let action = UIAlertAction(title: "Save".localized, style: .default) { (action2) in
            self.saveMovie(self.movie!)
        }
        
        let cancel = UIAlertAction(title: "Cancel".localized, style: .cancel) { (action) in }
        alert.addAction(cancel)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    
    }
    
    
    
    @IBAction func fetchDataBase(_ sender: UIButton) {
        var moviesList: [Movie] = []
        moviesList = RDatabase.fetchMovies()
        print("count: \(moviesList.count), \(moviesList)")
    }
    
    // MARK: Methods for Database

    func saveMovie(_ movie: Movie) {
        RDatabase.saveMovie(movie)
    }
    
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MovieDetailCell
        cell.initWithData(movie)
        return cell
    }
    
    
}
