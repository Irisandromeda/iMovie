//
//  ListenerService.swift
//  iMovie
//
//  Created by Irisandromeda on 16.06.2023.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

//MARK: Listener Service

class ListenerService {
    
    static let shared = ListenerService()
    
    private let db = Firestore.firestore()
    
    private var movieReference: CollectionReference {
        return db.collection("users").document(currentUserID).collection("favoriteMovies")
    }
    
    private var currentUserID: String {
        return Auth.auth().currentUser!.uid
    }
    
    func moviesListener(movies: [Movie], completion: @escaping (Result<[Movie],Error>) -> Void) -> ListenerRegistration? {
        var movies = movies
        let moviesListener = movieReference.addSnapshotListener { querySnapshot, error in
            guard let snapShot = querySnapshot else {
                completion(.failure(error!))
                return
            }
            snapShot.documentChanges.forEach { difference in
                guard let movie = Movie(queryDocument: difference.document) else { return }
                switch difference.type {
                    
                case .added:
                    guard !movies.contains(movie) else { return }
                    movies.append(movie)
                case .modified:
                    return
                case .removed:
                    guard let index = movies.firstIndex(of: movie) else { return }
                    movies.remove(at: index)
                }
            }
            completion(.success(movies))
        }
        return moviesListener
    }
}
