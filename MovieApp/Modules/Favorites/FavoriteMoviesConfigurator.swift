//
//  FavoriteMoviesConfigurator.swift
//  MovieApp
//
//  Created by Carlos Enrrique Fuentes Rojas on 19/12/23.
//

import UIKit

final class FavoriteMoviesConfigurator {
    
    static func configure() -> UIViewController {
        guard let view = UIStoryboard.init(name: "Main", bundle: Bundle(for: FavoriteMoviesViewController.self)).instantiateViewController(withIdentifier: FavoriteMoviesViewController.identifier) as? FavoriteMoviesViewController else { return UIViewController() }
        let presenter = FavoriteMoviePresenter(
            view: view,
            localRepository: MovieLocalRepository()
        )
        view.presenter = presenter
        return view
    }
    
}
