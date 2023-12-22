//
//  MovieLocalRepository.swift
//  MovieApp
//
//  Created by Carlos Enrrique Fuentes Rojas on 19/12/23.
//

import Foundation

protocol MovieLocalRepositoryProtocol {
    
    func getAllFavoriteMovies() -> [Movie]
    func insertFavoriteMovie(_ movie: Movie)
    func updateFavoriteMovie(movie: Movie)
    func removeFavoriteMovie(movie: Movie)
    
}

final class MovieLocalRepository: MovieLocalRepositoryProtocol {
    
    func getAllFavoriteMovies() -> [Movie] {
        let data = UserDefaults.standard.value(forKey: "movie_list") as? Data
        if let movieData = data {
            if let dataDecoded = try? JSONDecoder().decode(Array.self, from: movieData) as [Movie] {
                return dataDecoded
            } else {
                return [Movie]()
            }
        } else {
            return [Movie]()
        }
    }
    
    func insertFavoriteMovie(_ movie: Movie) {
        var movieList = getAllFavoriteMovies()
        movieList.append(movie)
        saveFavoriteMovies(movieList: movieList)
    }
    
    func updateFavoriteMovie(movie: Movie) {
        var movieList = getAllFavoriteMovies()
        if let idx = movieList.firstIndex(where: { $0.id ==  movie.id }) {
            movieList[idx] = movie
            saveFavoriteMovies(movieList: movieList)
        }
    }
    
    func removeFavoriteMovie(movie: Movie) {
        var movieList = getAllFavoriteMovies()
        if let idx = movieList.firstIndex(where: { $0.id == movie.id }) {
            movieList.remove(at: idx)
            saveFavoriteMovies(movieList: movieList)
        }
    }
    
    private func saveFavoriteMovies(movieList: [Movie]) {
        let encoder = JSONEncoder()
        if let dataEncoded = try? encoder.encode(movieList) {
            UserDefaults.standard.set(dataEncoded, forKey: "movie_list")
        }
    }
    
}
