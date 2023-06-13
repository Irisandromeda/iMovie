//
//  NetworkDataFetch.swift
//  iMovie
//
//  Created by Irisandromeda on 12.06.2023.
//

import Foundation

class NetworkDataFetch {
    
    static let shared = NetworkDataFetch()
    
    private init() {}
    
    func fetchMovie(url: String, response: @escaping (MovieModel?, Error?) -> Void) {
        
        NetworkRequest.shared.requestData(urlString: url) { result in
            switch result {
                
            case .success(let data):
                do {
                    let movies = try JSONDecoder().decode(MovieModel.self, from: data)
                    response(movies, nil)
                } catch let jsonError {
                    print("Failed to decode JSON, \(jsonError)")
                }
            case .failure(let error):
                print(error.localizedDescription)
                response(nil, error)
            }
        }
        
    }
    
}
