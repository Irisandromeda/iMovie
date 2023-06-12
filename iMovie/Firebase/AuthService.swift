//
//  AuthService.swift
//  iMovie
//
//  Created by Irisandromeda on 11.06.2023.
//

import UIKit
import Firebase
import FirebaseAuth

//MARK: Firebase Authentication

class AuthService {
    
    static let service = AuthService()
    private var auth = Auth.auth()
    
    //Login
    func login(email: String?, password: String?, completion: @escaping (Result<User,Error>) -> Void) {
        auth.signIn(withEmail: email!, password: password!) { result, error in
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            
            completion(.success(result.user))
        }
    }
    
    //Registration
    func registration(email: String?, password: String?, completion: @escaping (Result<User,Error>) -> Void) {
        auth.createUser(withEmail: email!, password: password!) { result, error in
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            
            completion(.success(result.user))
        }
    }
    
    //Confirm Email
    func confirmEmail() {
        auth.currentUser?.sendEmailVerification(completion: { error in
            guard error == nil else {
                print("Error")
                return
            }
            
            print("Success")
        })
    }
    
}
