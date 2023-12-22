//
//  MovieRemoteRepository.swift
//  MovieApp
//
//  Created by Carlos Enrrique Fuentes Rojas on 19/12/23.
//

import Foundation

protocol MovieRemoteRepositoryProtocol {
    
    func getMovies(completion: @escaping (Result<[Movie], MovieError>) -> Void)
    func getMoreMovies(page: Int, completion: @escaping (Result<[Movie], MovieError>) -> Void)
    
}

final class MovieRemoteRepository: MovieRemoteRepositoryProtocol {
    
    private let restClient = RestClient.sharedInstance
    
    func getMovies(completion: @escaping (Result<[Movie], MovieError>) -> Void) {
        restClient.request(MovieListRequest()) { result in
            switch result {
            case .success(let response):
                let movieList = response.results.map { movieResponse in
                    Movie(
                        id: movieResponse.id,
                        page: response.page,
                        title: movieResponse.title,
                        description: movieResponse.description.isEmpty ? "Sin descripcion" : movieResponse.description,
                        posterImageUrl: "https://image.tmdb.org/t/p/w500\(movieResponse.posterImagePath)",
                        backgroundImageUrl: "https://image.tmdb.org/t/p/w500\(movieResponse.imagePath ?? "")",
                        releaseDate: movieResponse.releaseDate ?? "",
                        isAdult: movieResponse.adult ?? false,
                        voteAverage: movieResponse.voteAverage ?? 0.0,
                        isFavorite: false
                    )
                }
                completion(.success(movieList))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func getMoreMovies(
        page: Int,
        completion: @escaping (Result<[Movie], MovieError>) -> Void
    ) {
        var request = MovieListRequest()
        let newPage = page + 1
        request.updateQueryItem(key: "page", value: "\(newPage)")
        restClient.request(request) { result in
            switch result {
            case .success(let response):
                let movieList = response.results.map { movieResponse in
                    Movie(
                        id: movieResponse.id,
                        page: response.page,
                        title: movieResponse.title,
                        description: movieResponse.description.isEmpty ? "Sin descripcion" : movieResponse.description,
                        posterImageUrl: "https://image.tmdb.org/t/p/w500\(movieResponse.posterImagePath)",
                        backgroundImageUrl: "https://image.tmdb.org/t/p/w500\(movieResponse.imagePath ?? "")",
                        releaseDate: movieResponse.releaseDate ?? "",
                        isAdult: movieResponse.adult ?? false,
                        voteAverage: movieResponse.voteAverage ?? 0.0,
                        isFavorite: false
                    )
                }
                completion(.success(movieList))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
}
