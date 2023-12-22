//
//  MovieListRequest.swift
//  MovieApp
//
//  Created by Carlos Enrrique Fuentes Rojas on 15/12/23.
//

import Foundation

struct MovieListRequest: BaseRequest {
    
    typealias Response = MovieListResponse
    
    var baseUrl: String { "https://api.themoviedb.org/3" }
    
    var service: String { "/movie" }
    
    var path: String { "/popular" }
    
    var method: HTTPMethod { .GET }
    
    var headers: [String: String] {
        [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmMzkxNmJkMGZkOTk3ODFjNjE0OWRmOWZlYTI5ODAzOSIsInN1YiI6IjY1NTRlMThhNTM4NjZlMDEzOWUxYmJhMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.NRUd1H1OCYS3DEkj580kC3RRaRGs9SDoxAvfojN0Qvw"
        ]
    }
    
    var queryItems: [String: String] = [
        "language": "es-ES",
        "page": "1"
    ]
    
    mutating func updateQueryItem(key: String, value: String) {
        self.queryItems[key] = value
    }
    
}

struct MovieListResponse: Decodable {
    
    let page: Int
    let results: [MovieResponse]
    
}

struct MovieResponse: Decodable {
    
    let id: Int
    let title: String
    let imagePath: String?
    let posterImagePath: String
    let description: String
    let language: String?
    let releaseDate: String?
    let voteAverage: Double?
    let adult: Bool?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case title = "title"
        case imagePath = "backdrop_path"
        case posterImagePath = "poster_path"
        case description = "overview"
        case language = "original_language"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case adult = "adult"
        
    }
    
}
