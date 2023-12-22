//
//  HomeConfigurator.swift
//  MovieApp
//
//  Created by Carlos Enrrique Fuentes Rojas on 15/12/23.
//
import UIKit

final class HomeConfigurator {
    
    static func configure() -> UIViewController {
        guard let view = UIStoryboard.init(name: "Main", bundle: Bundle(for: HomeViewController.self)).instantiateViewController(withIdentifier: HomeViewController.identifier) as? HomeViewController else { return UIViewController() }
        let presenter = HomePresenter(
            view: view,
            localRepository: MovieLocalRepository(),
            remoteRepository: MovieRemoteRepository()
        )
        view.presenter = presenter
        return view
    }
    
}
