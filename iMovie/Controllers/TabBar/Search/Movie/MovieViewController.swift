//
//  MovieViewController.swift
//  iMovie
//
//  Created by Irisandromeda on 14.06.2023.
//

import UIKit
import SDWebImage

class MovieViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieDescription: UITextView!
    @IBOutlet weak var movieImage: UIImageView!
    
    private var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    private func configure() {
        movieName.text = movie.trackName
        movieGenre.text = movie.primaryGenreName
        movieYear.text = movie.releaseDate
        movieDescription.text = movie.longDescription
        
        if let imageURL = movie.artworkUrl100 {
            movieImage.sd_setImage(with: URL(string: imageURL))
        }
    }

}
