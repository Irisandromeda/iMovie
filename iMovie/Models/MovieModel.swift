//
//  MovieModel.swift
//  iMovie
//
//  Created by Irisandromeda on 12.06.2023.
//

import Foundation
import FirebaseFirestore

struct MovieModel: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    let trackName: String
    let primaryGenreName: String
    let releaseDate: String
    let longDescription: String
    let artworkUrl100: String?
    
    var dictionary: [String: Any] {
        var key = ["movieName": trackName]
        key["movieGenre"] = primaryGenreName
        key["date"] = releaseDate
        key["movieDescription"] = longDescription
        key["image"] = artworkUrl100
        
        return key
    }
}

