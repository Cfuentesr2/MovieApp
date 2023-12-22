//
//  MovieTabBarController.swift
//  MovieApp
//
//  Created by Carlos Enrrique Fuentes Rojas on 15/12/23.
//
import UIKit

final class MovieTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    
    var isHiddenTab: Bool = false {
        didSet {
            UIView.animate(withDuration: 0.1) {
                self.tabBar.isUserInteractionEnabled = !self.isHiddenTab
                self.tabBar.isHidden = self.isHiddenTab
            }
        }
    }
    
    private func configureTabBar() {
        let homeViewController = HomeConfigurator.configure()
        let favoriteViewController = FavoriteMoviesConfigurator.configure()
        
        let navigationHome = UINavigationController(rootViewController: homeViewController)
        let navigationFavorite = UINavigationController(rootViewController: favoriteViewController)
        
        homeViewController.tabBarItem.title = "Inicio"
        favoriteViewController.tabBarItem.title = "Favoritos"
        
        tabBar.barTintColor = .white
        tabBar.tintColor = .white
        tabBar.backgroundColor = UIColor(hex: "#0D253F")
        
        setViewControllers(
            [
                navigationHome,
                navigationFavorite
            ],
            animated: false
        )
    }
    
}

