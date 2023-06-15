//
//  FireStoreService.swift
//  iMovie
//
//  Created by Irisandromeda on 15.06.2023.
//

import Firebase
import FirebaseCore
import FirebaseFirestore

class FireStoreService {
    
    static let shared = FireStoreService()
    
    let db = Firestore.firestore()
    
    private var favoriteMoviesReference: CollectionReference {
        return db.collection("favoriteMovies")
    }
    
    func saveFavoriteMovie(userId: String, movie: Movie, completion: @escaping (Result<Movie,Error>) -> Void) {
        let movie = movie
        favoriteMoviesReference.document(userId).setData(movie.dictionary) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(movie))
            }
        }
    }
    
}
