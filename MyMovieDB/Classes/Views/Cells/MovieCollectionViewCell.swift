//
//  MovieCollectionViewCell.swift
//  MyMovieDB
//
//  Created by Fabiola Ramirez on 8/6/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func initWithData(_ movie: Movie) {
        titleLabel.text = movie.Title
        if let poster = movie.Poster {
            imageView.sd_setImage(with: URL(string: poster), placeholderImage: UIImage(named: "notFound"))
        }
    }
    
    
}
