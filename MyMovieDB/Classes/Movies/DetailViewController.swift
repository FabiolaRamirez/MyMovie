//
//  DetailViewController.swift
//  MyMovieDB
//
//  Created by Fabiola Ramirez on 8/6/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import UIKit

protocol DetailMoviePresenterDelegate {
    func saveMovie(movie: Movie)
    func existMovie(movie: Movie)
}

protocol DetailMovieDeletionPresenterDelegate {
    func deleteMovie(movie: Movie)
}

class DetailViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var saveOrDeleteItem: UIBarButtonItem!
    
    private let cellIdentifier = "movieDetailCell"
    var movieId: String?
    var movie: Movie?
    var detailMoviePresenter: DetailMoviePresenterDelegate?
    var isItemForDeletingState = false
    var detailMovieDeletionPresenter: DetailMovieDeletionPresenterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        tableView.register(UINib.init(nibName: "MovieDetailCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.detailMoviePresenter = DetailMoviePresenter(delegate: self)
        self.detailMovieDeletionPresenter = DetailMovieDeletionPresenter(delegate: self)
        if isItemForDeletingState {
            saveOrDeleteItem.title = "Delete".localized
            saveOrDeleteItem.tintColor = .red
        } else {
            saveOrDeleteItem.title = "Save".localized
        }
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
    
    @IBAction func saveOrDelete(_ sender: UIBarButtonItem) {
        if isItemForDeletingState {
            let alert = UIAlertController(title: "", message: "DeleteMessage".localized, preferredStyle: .alert)
            let action = UIAlertAction(title: "Delete".localized, style: .default) { (action2) in
                self.detailMovieDeletionPresenter?.deleteMovie(movie: self.movie!)
            }
            let cancel = UIAlertAction(title: "Cancel".localized, style: .cancel) { (action) in }
            alert.addAction(cancel)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        } else {
            self.detailMoviePresenter?.existMovie(movie: self.movie!)
        }
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

extension DetailViewController: MovieDetailProtocol {

    
    func movieAlreadyExist() {
        showSimpleAlert(title: "", message: "\(self.movie!.Title ?? "") \("AlreadySavedMessage".localized)")
    }
    
    func movieCanBeSaved() {
        let alert = UIAlertController(title: "", message: "SaveMessage".localized, preferredStyle: .alert)
        let action = UIAlertAction(title: "Save".localized, style: .default) { (action2) in
            self.detailMoviePresenter?.saveMovie(movie: self.movie!)
        }
        
        let cancel = UIAlertAction(title: "Cancel".localized, style: .cancel) { (action) in }
        alert.addAction(cancel)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

extension DetailViewController: MovieDeletedProtocol {
    func successfullyMovieDeleted() {
        print("successfully Deleted!")
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
