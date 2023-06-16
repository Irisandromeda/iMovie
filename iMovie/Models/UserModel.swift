//
//  UserModel.swift
//  iMovie
//
//  Created by Irisandromeda on 16.06.2023.
//

import Foundation
import FirebaseFirestore

struct UserModel {
    let userID: String
    let email: String
    let username: String
    
    init(userID: String, email: String, username: String) {
        self.userID = userID
        self.email = email
        self.username = username
    }
    
    var dictionary: [String:Any] {
        var key = ["userID": userID]
        key["email"] = email
        key["username"] = username
        
        return key
    }
    
    init?(document: DocumentSnapshot) {
        guard let data = document.data() else { return nil }
        guard let userID = data["userID"] as? String,
        let email = data["email"] as? String,
        let username = data["username"] as? String else { return nil }

        self.userID = userID
        self.email = email
        self.username = username
    }
}
