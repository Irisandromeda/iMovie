//
//  MovieModel.swift
//  iMovie
//
//  Created by Irisandromeda on 12.06.2023.
//

import Foundation

struct MovieModel: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    let trackName: String
    let primaryGenreName: String
    let releaseDate: String
    let longDescription: String
    let artworkUrl100: String?
}
