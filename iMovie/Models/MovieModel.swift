//
//  MovieModel.swift
//  iMovie
//
//  Created by Irisandromeda on 12.06.2023.
//

import Foundation
import FirebaseFirestore

struct MovieModel: Hashable, Decodable {
    let results: [Movie]
}

struct Movie: Decodable, Hashable {
    let trackName: String
    let primaryGenreName: String
    let releaseDate: String
    let longDescription: String
    let artworkUrl100: String?
    let collectionViewUrl: String?
    
    var dictionary: [String: Any] {
        var key = ["movieName": trackName]
        key["movieGenre"] = primaryGenreName
        key["date"] = releaseDate
        key["movieDescription"] = longDescription
        key["image"] = artworkUrl100
        key["appleTVLink"] = collectionViewUrl
        
        return key
    }
    
    init?(queryDocument: QueryDocumentSnapshot) {
        let data = queryDocument.data()
        guard let trackName = data["movieName"] as? String,
        let primaryGenreName = data["movieGenre"] as? String,
        let releaseDate = data["date"] as? String,
        let longDescription = data["movieDescription"] as? String,
        let artworkUrl100 = data["image"] as? String,
        let collectionViewUrl = data["appleTVLink"] as? String else { return nil }
        
        self.trackName = trackName
        self.primaryGenreName = primaryGenreName
        self.releaseDate = releaseDate
        self.longDescription = longDescription
        self.artworkUrl100 = artworkUrl100
        self.collectionViewUrl = collectionViewUrl
    }
}

