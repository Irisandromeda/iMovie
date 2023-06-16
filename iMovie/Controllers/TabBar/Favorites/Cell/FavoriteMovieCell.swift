//
//  FavoriteMovieCell.swift
//  iMovie
//
//  Created by Irisandromeda on 16.06.2023.
//

import UIKit

class FavoriteMovieCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configureCell(movie: Movie) {
        movieName.text = movie.trackName
        
        if let imageURL = movie.artworkUrl100 {
            movieImage.sd_setImage(with: URL(string: imageURL))
        }
    }
    
}
