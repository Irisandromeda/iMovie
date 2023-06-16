//
//  MovieViewController.swift
//  iMovie
//
//  Created by Irisandromeda on 14.06.2023.
//

import UIKit
import SDWebImage
import FirebaseAuth

class MovieViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieDescription: UITextView!
    @IBOutlet weak var movieImage: UIImageView!
    
    private var currentUser: UserModel
    private var movie: Movie
    
    init(user: UserModel, movie: Movie) {
        self.currentUser = user
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

    @IBAction func saveMovieAction(_ sender: UIButton) {
        FireStoreService.shared.saveFavoriteMovie(userId: currentUser.userID, movie: movie) { result in
            switch result {
                
            case .success(_):
                print("Movie - Saved")
            case .failure(let error):
                self.showAlert(title: "Something was wrong!", message: error.localizedDescription)
            }
        }
    }
    
    
    @IBAction func shareMovieAction(_ sender: UIButton) {
        guard let movieLink = movie.collectionViewUrl else { return }
        share(movieLink: movieLink)
    }
    
    private func share(movieLink: String) {
        var items: [String] = []
        items.append(movieLink)
        
        let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        present(activityViewController, animated: true, completion: nil)
    }
    
}
