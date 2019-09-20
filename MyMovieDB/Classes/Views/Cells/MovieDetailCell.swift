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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initWithData(_ movie: Movie?) {
        
        //FIXME: Let's not use wired strings.. we can have a struct with constants. this is even helpfull for localization. 
        genreTitleLabel.text = "Genre"
        genreLabel.text = movie?.Title ?? "None"
        languageLabel.text = movie?.Genre ?? "No Language"
        yearLabel.text = movie?.Year ?? "No Year"
        ratingTitleLabel.text = "Rate"
        ratingLabel.text = movie?.imdbRating ?? "None"
        plotLabel.text = movie?.Plot ?? ""
        
        if let poster = movie?.Poster {
            movieImageView.sd_setImage(with: URL(string: poster), placeholderImage: UIImage(named: "notFound"))
        }
        
        
    }
    
    
    
}
