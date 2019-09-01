//
//  MoviesViewController.swift
//  MyMovieDB
//
//  Created by Fabiola Ramirez on 8/6/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import UIKit


class MoviesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    let cellMovieIdentifier = "movieCellIdentifier"
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var simpleSearch = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCells()
        setupCollectionViewItenSize()
    }
    
    func setupCollectionViewItenSize() {
        if collectionViewFlowLayout == nil {
            let numberOfItemPerRow: CGFloat = 4
            let lineSpacing: CGFloat = 5
            let interItemSpacing: CGFloat = 5
            let width = (collectionView.frame.width - (numberOfItemPerRow - 1) * interItemSpacing) / numberOfItemPerRow
            let height = width + 30
            collectionViewFlowLayout = UICollectionViewFlowLayout()
            collectionViewFlowLayout.itemSize = CGSize(width: width, height: height)
            collectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
            collectionViewFlowLayout.scrollDirection = .vertical
            collectionViewFlowLayout.minimumLineSpacing = lineSpacing
            collectionViewFlowLayout.minimumInteritemSpacing = interItemSpacing
            collectionViewFlowLayout.headerReferenceSize = CGSize(width: self.collectionView.frame.size.width, height: 50)
            collectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        }
    }
    
    func setupCells() {
        let nib = UINib(nibName: "MovieCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: cellMovieIdentifier)
    }

}

extension MoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if simpleSearch {
            return SearchMovie.shared.favoriteMovies1.count
        } else {
            switch section {
            case 0:
                return SearchMovie.shared.favoriteMovies1.count
            case 1:
                return SearchMovie.shared.favoriteMovies2.count
            case 2:
                return SearchMovie.shared.favoriteMovies3.count
            case 3:
                return SearchMovie.shared.favoriteMovies4.count
            case 4:
                return SearchMovie.shared.favoriteMovies5.count
            default:
                return 0
            }
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellMovieIdentifier, for: indexPath) as! MovieCollectionViewCell
        var movie = Movie()
        if simpleSearch {
            movie = SearchMovie.shared.favoriteMovies1[indexPath.row]
        } else {
            switch indexPath.section {
            case 0:
                movie = SearchMovie.shared.favoriteMovies1[indexPath.row]
            case 1:
                movie = SearchMovie.shared.favoriteMovies2[indexPath.row]
            case 2:
                movie = SearchMovie.shared.favoriteMovies3[indexPath.row]
            case 3:
                movie = SearchMovie.shared.favoriteMovies4[indexPath.row]
            case 4:
                movie = SearchMovie.shared.favoriteMovies5[indexPath.row]
            default:
                break
            }
        }
        
        cell.initWithData(movie)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if simpleSearch {
            return 1
        } else {
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerViewIdentifier", for: indexPath) as? RecipeCollectionReusableView {
            var titleSection = ""
            if simpleSearch {
                if SearchMovie.shared.favoriteMovies1.isEmpty {
                    titleSection = "\(SearchMovie.shared.movieTitles[indexPath.section]) Not Found"
                } else {
                    titleSection = "\(SearchMovie.shared.movieTitles[indexPath.section]) (\(SearchMovie.shared.favoriteMovies1.count) coincidences)"
                }
            } else {
                switch indexPath.section {
                case 0:
                    if SearchMovie.shared.favoriteMovies1.isEmpty {
                        titleSection = "\(SearchMovie.shared.movieTitles[indexPath.section]) Not Found"
                    } else {
                        titleSection = "\(SearchMovie.shared.movieTitles[indexPath.section]) (\(SearchMovie.shared.favoriteMovies1.count) coincidences)"
                    }
                case 1:
                    if SearchMovie.shared.favoriteMovies2.isEmpty {
                        titleSection = "\(SearchMovie.shared.movieTitles[indexPath.section]) Not Found"
                    } else {
                        titleSection = "\(SearchMovie.shared.movieTitles[indexPath.section]) (\(SearchMovie.shared.favoriteMovies2.count) coincidences)"
                    }
                case 2:
                    if SearchMovie.shared.favoriteMovies3.isEmpty {
                        titleSection = "\(SearchMovie.shared.movieTitles[indexPath.section]) Not Found"
                    } else {
                        titleSection = "\(SearchMovie.shared.movieTitles[indexPath.section]) (\(SearchMovie.shared.favoriteMovies3.count) coincidences)"
                    }
                case 3:
                    if SearchMovie.shared.favoriteMovies4.isEmpty {
                        titleSection = "\(SearchMovie.shared.movieTitles[indexPath.section]) Not Found"
                    } else {
                        titleSection = "\(SearchMovie.shared.movieTitles[indexPath.section]) (\(SearchMovie.shared.favoriteMovies4.count) coincidences)"
                    }
                case 4:
                    if SearchMovie.shared.favoriteMovies5.isEmpty {
                        titleSection = "\(SearchMovie.shared.movieTitles[indexPath.section]) Not Found"
                    } else {
                        titleSection = "\(SearchMovie.shared.movieTitles[indexPath.section]) (\(SearchMovie.shared.favoriteMovies5.count) coincidences)"
                    }
                default: break
                }
            }
            sectionHeader.titleLabel.text = titleSection
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var movieId = ""
        if simpleSearch {
            movieId = SearchMovie.shared.favoriteMovies1[indexPath.row].imdbID!
        } else {
            switch indexPath.section {
            case 0:
                movieId = SearchMovie.shared.favoriteMovies1[indexPath.row].imdbID!
            case 1:
                movieId = SearchMovie.shared.favoriteMovies2[indexPath.row].imdbID!
            case 2:
                movieId = SearchMovie.shared.favoriteMovies3[indexPath.row].imdbID!
            case 3:
                movieId = SearchMovie.shared.favoriteMovies4[indexPath.row].imdbID!
            case 4:
                movieId = SearchMovie.shared.favoriteMovies5[indexPath.row].imdbID!
            default: break
            }
        }
        showMovieDetail(movieId: movieId)
    }
    
    
    func showMovieDetail(movieId: String) {
        let vc: DetailViewController = UIViewController.instantiateViewController(storyBoard: "Movie", identifier: "detailViewController") as! DetailViewController
        vc.movieId = movieId
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
}
