//
//  Model.swift
//  iMovie
//
//  Created by Irisandromeda on 13.06.2023.
//

import Foundation

protocol ModelProtocol {
    var movies: [Movie] { get set}
    func fetchMovies(movieName: String)
}

class Model: ModelProtocol {
    
    static let shared = Model()
    
    var movies: [Movie] = []
    
    func fetchMovies(movieName: String) {
        
        let urlString = "https://itunes.apple.com/search?term=\(movieName)&country=us&entity=movie&limit=15"
        
        NetworkDataFetch.shared.fetchMovie(url: urlString) { movieModel, error in
            
            if error == nil {
                
                guard let movieModel = movieModel else { return }
                
                self.movies = movieModel.results
                print(movieModel.results)
            } else {
                print(error!.localizedDescription)
            }
        }
        
    }
}
