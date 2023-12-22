//
//  MovieDetailPresenter.swift
//  MovieApp
//
//  Created by Carlos Enrrique Fuentes Rojas on 19/12/23.
//

import Foundation

protocol MovieDetailPresenterProtocol {
    
    func insertFavoriteMovie(using movie: Movie)
    func removeFavoriteMovie(using movie: Movie)
    
}

final class MovieDetailPresenter {
    
    private weak var view: MovieDetailView?
    private var localRepository: MovieLocalRepositoryProtocol
    
    init(
        view: MovieDetailView?,
        localRepository: MovieLocalRepositoryProtocol
    ) {
        self.view = view
        self.localRepository = localRepository
    }
    
}

extension MovieDetailPresenter: MovieDetailPresenterProtocol {
    
    func insertFavoriteMovie(using movie: Movie) {
        localRepository.insertFavoriteMovie(movie)
        view?.showMessage(message: "Tu película es agregada a favoritos.")
    }
    
    func removeFavoriteMovie(using movie: Movie) {
        localRepository.removeFavoriteMovie(movie: movie)
        view?.showMessage(message: "Tu película es eliminada de favoritos.")
    }
    
}
