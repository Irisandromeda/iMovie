//
//  SearchMovieCell.swift
//  iMovie
//
//  Created by Irisandromeda on 13.06.2023.
//

import UIKit
import SDWebImage

class SearchMovieCell: UICollectionViewCell {
    
    //Outlets
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    func configureCell(movies: Movie) {
        movieName.text = movies.trackName
        movieGenre.text = movies.primaryGenreName
        
        if let imageURL = movies.artworkUrl100 {
            movieImage.sd_setImage(with: URL(string: imageURL))
        }
    }
}
