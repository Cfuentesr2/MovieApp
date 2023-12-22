//
//  MovieDetailConfigure.swift
//  MovieApp
//
//  Created by Carlos Enrrique Fuentes Rojas on 19/12/23.
//

import UIKit

final class MovieDetailConfigure {
    
    static func configure(
        movie: Movie
    ) -> UIViewController {
        guard let view = UIStoryboard.init(name: "Main", bundle: Bundle(for: MovieDetailViewController.self)).instantiateViewController(withIdentifier: MovieDetailViewController.identifier) as? MovieDetailViewController else { return UIViewController() }
        let presenter = MovieDetailPresenter(
            view: view,
            localRepository: MovieLocalRepository()
        )
        view.presenter = presenter
        view.movie = movie
        view.isFavorite = movie.isFavorite
        return view
    }
    
}
