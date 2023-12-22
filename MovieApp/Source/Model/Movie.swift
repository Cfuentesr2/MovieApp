//
//  Movie.swift
//  MovieApp
//
//  Created by Carlos Enrrique Fuentes Rojas on 18/12/23.
//

import Foundation

struct Movie: Codable {
    
    let id: Int
    let page: Int
    let title: String
    let description: String
    let posterImageUrl: String
    let backgroundImageUrl: String
    let releaseDate: String
    let isAdult: Bool
    let voteAverage: Double
    var isFavorite: Bool = false
    
}
