//
//  Model.swift
//  iMovie
//
//  Created by Irisandromeda on 13.06.2023.
//

import UIKit

protocol ModelProtocol {
    var movies: [Movie] { get set}
    var collectionView: UICollectionView? { get set }
}

class Model: ModelProtocol {
    
    static let shared = Model()
    
    var movies: [Movie] = []
    
    var collectionView: UICollectionView?
    
    func fetchMovies(movieName: String, collectionView: UICollectionView) {
        
        let urlString = "https://itunes.apple.com/search?term=\(movieName)&country=us&entity=movie&limit=15"
        
        NetworkDataFetch.shared.fetchMovie(url: urlString) { movieModel, error in
            
            if error == nil {
                
                guard let movieModel = movieModel else { return }
                
                self.movies = movieModel.results
                collectionView.reloadData()
                self.collectionView = collectionView
                print(movieModel.results)
                print(self.movies.count)
            } else {
                print(error!.localizedDescription)
            }
        }
        
    }
}
