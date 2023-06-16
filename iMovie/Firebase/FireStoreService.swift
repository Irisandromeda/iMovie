//
//  FireStoreService.swift
//  iMovie
//
//  Created by Irisandromeda on 15.06.2023.
//

import Firebase
import FirebaseCore
import FirebaseFirestore

//MARK: Firebase Firestore Service

class FireStoreService {
    
    static let shared = FireStoreService()
    
    private let db = Firestore.firestore()
    
    private var userReference: CollectionReference {
        return db.collection("users")
    }
    
    private var currentUser: UserModel!
    
//MARK: Save Data
    
    func saveUserData(userID: String, email: String, username: String, completion: @escaping (Result<UserModel,Error>) -> Void) {
        let user = UserModel(userID: userID,
                             email: email,
                             username: username)
        
        userReference.document(userID).setData(user.dictionary) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(user))
            }
        }
    }
    
    func saveFavoriteMovie(userId: String, movie: Movie, completion: @escaping (Result<Movie,Error>) -> Void) {
        let movie = movie
        userReference.document(userId).collection("favoriteMovies").document(movie.trackName).setData(movie.dictionary) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(movie))
            }
        }
    }
    
//MARK: Get Data
    
    func getUserData(user: User, completion: @escaping (Result<UserModel,Error>) -> Void) {
        let documentReference = userReference.document(user.uid)
        documentReference.getDocument { document, error in
            if let document = document {
                guard let user = UserModel(document: document) else {
                    completion(.failure(error!))
                    return
                }
                self.currentUser = user
                completion(.success(user))
            } else {
                completion(.failure(error!))
            }
        }
    }
    
    func getFavoriteMovies(completion: @escaping (Result<[Movie],Error>) -> Void) {
        let reference = userReference.document(currentUser.userID).collection("favoriteMovies")
        var movies: [Movie] = []
        
        reference.getDocuments { querySnapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            } else {
                for document in querySnapshot!.documents {
                    guard let movie = Movie(queryDocument: document) else { return }
                    movies.append(movie)
                }
                completion(.success(movies))
            }
        }
    }
    
//MARK: Delete Data
    
    func deleteMovie(movie: Movie, completion: @escaping (Result<Void, Error>) -> Void) {
        userReference.document(currentUser.userID).collection("favoriteMovies").document(movie.trackName).delete { error in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(Void()))
        }
    }
}
