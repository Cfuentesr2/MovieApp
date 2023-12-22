//
//  HomePresenter.swift
//  MovieApp
//
//  Created by Carlos Enrrique Fuentes Rojas on 18/12/23.
//

import Foundation

protocol HomePresenterProtocol {
    
    var movieListCount: Int { get }
    
    func loadMovies()
    func loadMoreMovies()
    func getMovie(at index: Int) -> Movie
    func didTapMovie(at index: Int)
    
}

class HomePresenter {
    
    private weak var view: HomeView?
    private var localRepository: MovieLocalRepositoryProtocol
    private var remoteRepository: MovieRemoteRepositoryProtocol
    
    private var movieList: [Movie] = []
    
    init(
        view: HomeView,
        localRepository: MovieLocalRepositoryProtocol,
        remoteRepository: MovieRemoteRepositoryProtocol
    ) {
        self.view = view
        self.localRepository = localRepository
        self.remoteRepository = remoteRepository
    }
    
}

extension HomePresenter: HomePresenterProtocol {
    
    var movieListCount: Int { movieList.count }
    
    func loadMovies() {
        view?.showProgress(withNewData: false)
        remoteRepository.getMovies { [weak self] result in
            guard let self = self else { return }
            self.view?.hideProgress()
            switch result {
            case .success(let movieList):
                self.movieList = movieList
                view?.showInformation(usingCase: self.movieList.isEmpty ? .empty : .withData)
                view?.reloadTableView()
            case .failure:
                view?.showInformation(usingCase: .error)
            }
        }
    }
    
    func loadMoreMovies() {
        view?.showProgress(withNewData: true)
        remoteRepository.getMoreMovies(page: movieList.last?.page ?? 1) { [weak self] result in
            guard let self = self else { return }
            self.view?.hideProgress()
            switch result {
            case .success(let movieList):
                if !movieList.isEmpty {
                    self.movieList.append(contentsOf: movieList)
                }
                view?.showInformation(usingCase: self.movieList.isEmpty ? .empty : .withData)
                self.movieList = self.movieList
                view?.reloadTableView()
            case .failure:
                view?.showInformation(usingCase: .error)
            }
        }
    }
    
    func getMovie(at index: Int) -> Movie {
        return movieList[index]
    }
    
    func didTapMovie(at index: Int) {
        var movie = movieList[index]
        let movieFavoriteList = localRepository.getAllFavoriteMovies()
        guard let _ = movieFavoriteList.first(where: { $0.id == movie.id }) else {
            view?.navigateToDetail(using: movie)
            return
        }
        movie.isFavorite = true
        view?.navigateToDetail(using: movie)
    }
    
}
