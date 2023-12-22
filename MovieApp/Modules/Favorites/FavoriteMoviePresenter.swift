//
//  FavoriteMoviePresenter.swift
//  MovieApp
//
//  Created by Carlos Enrrique Fuentes Rojas on 20/12/23.
//

import Foundation

protocol FavoriteMoviePresenterProtocol {
    
    var favoriteMoviesCount: Int { get }
    
    func loadFavoriteMovies()
    func getFavoriteMovie(at index: Int) -> Movie
    func didTapFavoriteMovie(at index: Int)
    
}

final class FavoriteMoviePresenter {
    
    private weak var view: FavoriteMoviesView?
    private var localRepository: MovieLocalRepositoryProtocol
    
    private var favoriteMovies: [Movie] = []
    
    init(
        view: FavoriteMoviesView?,
        localRepository: MovieLocalRepositoryProtocol
    ) {
        self.view = view
        self.localRepository = localRepository
    }
    
}

extension FavoriteMoviePresenter: FavoriteMoviePresenterProtocol {
    
    var favoriteMoviesCount: Int { favoriteMovies.count }
    
    func loadFavoriteMovies() {
        favoriteMovies = localRepository.getAllFavoriteMovies()
        view?.showInformation(usingCase: favoriteMovies.isEmpty ? .empty : .withData)
        view?.reloadCollectionView()
    }
    
    func getFavoriteMovie(at index: Int) -> Movie {
        return favoriteMovies[index]
    }
    
    func didTapFavoriteMovie(at index: Int) {
        var movie = favoriteMovies[index]
        let movieFavoriteList = localRepository.getAllFavoriteMovies()
        guard let _ = movieFavoriteList.first(where: { $0.id == movie.id }) else {
            view?.navigateToDetail(using: movie)
            return
        }
        movie.isFavorite = true
        view?.navigateToDetail(using: movie)
    }
    
}
