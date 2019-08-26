//
//  MovieSavedCell.swift
//  MyMovieDB
//
//  Created by Fabiola Ramirez on 8/20/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import UIKit

class MovieSavedCell: UITableViewCell {

    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initWithData(_ movie: Movie?) {
        titleLabel.text = movie?.Title ?? ""
        yearLabel.text = movie?.Year ?? ""
        if let poster = movie?.Poster {
            movieImageView.sd_setImage(with: URL(string: poster), placeholderImage: UIImage(named: "notFound"))
        }
    }
    
}
