//
//  MovieDetailCell.swift
//  MyMovieDB
//
//  Created by Fabiola Ramirez on 8/18/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import UIKit

class MovieDetailCell: UITableViewCell {

    
    @IBOutlet weak var genreTitleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var ratingTitleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        genreTitleLabel.font = UIFont.neueMedium(14)
        genreLabel.font = UIFont.neueRegular(14)
        genreLabel.textColor = .grayRegular
        languageLabel.font = UIFont.neueMedium(14)
        yearLabel.font = UIFont.neueMedium(14)
        ratingTitleLabel.font = UIFont.neueMedium(14)
        ratingLabel.font = UIFont.neueRegular(14)
        ratingLabel.textColor = .grayRegular
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initWithData(_ movie: Movie?) {
        genreTitleLabel.text = MovieLabels.genre
        genreLabel.text = movie?.Title ?? MovieLabels.none
        languageLabel.text = movie?.Genre ?? MovieLabels.noLanguage
        yearLabel.text = movie?.Year ?? MovieLabels.noYear
        ratingTitleLabel.text = MovieLabels.rate
        ratingLabel.text = movie?.imdbRating ?? MovieLabels.none
        plotLabel.text = movie?.Plot ?? ""
        
        if let poster = movie?.Poster {
            movieImageView.sd_setImage(with: URL(string: poster), placeholderImage: UIImage(named: "notFound"))
        }
        
        
    }
    
    
    
}
