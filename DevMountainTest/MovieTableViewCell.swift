//
//  MovieTableViewCell.swift
//  DevMountainTest
//
//  Created by tyson ericksen on 11/22/19.
//  Copyright © 2019 tyson ericksen. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    var movie: Movie? {
        didSet {
            updateView()
        }
    }

    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    
    
    
    func updateView() {
        guard let movie = movie else { return }
        MovieController.fetchImage(movie) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.moviePosterImageView.image = image
                case .failure(let error):
                    print(error, error.localizedDescription)
                }
            }
        }
        movieTitleLabel.text = movie.title
        movieRatingLabel.text = "\(movie.vote_average)"
        movieDescriptionLabel.text = movie.overview
    }
    
    
}
