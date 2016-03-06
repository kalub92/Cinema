//
//  MovieCell.swift
//  Cinema
//
//  Created by Caleb Stultz on 3/6/16.
//  Copyright © 2016 Caleb Stultz. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var movieImg: RoundedCornersVC!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var imdbLink: UILabel!
    @IBOutlet weak var movieReview: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

}

    func configureCell(movie: Movie) {
        movieTitle.text = movie.title
        movieImg.image = movie.getMovieImg()
        movieReview.text = movie.review
        imdbLink.text = movie.link
    }

}

