//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Carlos Enrrique Fuentes Rojas on 19/12/23.
//

import UIKit

protocol MovieDetailView: AnyObject {
    
    func showMessage(message: String)
    
}


class MovieDetailViewController: UIViewController {

    static let identifier = "MovieDetailViewController"
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var favoriteContainerView: UIView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var informationRestrictionLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    
    var presenter: MovieDetailPresenterProtocol!
    var movie: Movie!
    var isFavorite: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        backgroundImageView.loadImage(
            withURL: movie.backgroundImageUrl,
            defaultImage: UIImage(named: "ic-film")!
        )
        favoriteContainerView.addRadius(cornerRadius: 26.0)
        titleLabel.text = movie.title
        descriptionLabel.text = movie.description
        favoriteButton.setImage(isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)
        informationRestrictionLabel.text = "Restricción: \(movie.isAdult ? "Para mayores de edad" : "Apto para todos")"
        voteAverageLabel.text = "Votación o Preferencia: \(movie.voteAverage)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (self.tabBarController as? MovieTabBarController)?.isHiddenTab = true
    }
    
    @IBAction func favoriteButtonAction(_ sender: Any) {
        if isFavorite {
            presenter.removeFavoriteMovie(using: movie)
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            movie.isFavorite = true
            presenter.insertFavoriteMovie(using: movie)
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        isFavorite = !isFavorite
    }
    
}

extension MovieDetailViewController: MovieDetailView {
    
    func showMessage(message: String) {
        let alertInfo = UIAlertController(title: "MovieApp", message: message, preferredStyle: .alert)
        alertInfo.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { _ in }))
        present(alertInfo, animated: true, completion: nil)
    }
    
}
