//
//  FavoriteMoviesViewController.swift
//  MovieApp
//
//  Created by Carlos Enrrique Fuentes Rojas on 18/12/23.
//

import UIKit

enum FavoriteMoviesCases {
    
    case withData
    case empty
    
}

protocol FavoriteMoviesView: AnyObject {
    
    func showInformation(usingCase favoriteCases: FavoriteMoviesCases)
    func reloadCollectionView()
    func navigateToDetail(using movie: Movie)
    
}

final class FavoriteMoviesViewController: UIViewController {

    static let identifier = "FavoriteMoviesViewController"
    
    @IBOutlet weak var informationContainerView: UIView!
    @IBOutlet weak var informationImageView: UIImageView!
    @IBOutlet weak var informationTitleLabel: UILabel!
    @IBOutlet weak var informationDescriptionLabel: UILabel!
    @IBOutlet weak var favoriteMovieCollectionView: UICollectionView!
    
    var presenter: FavoriteMoviePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInformationView()
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        (self.tabBarController as? MovieTabBarController)?.isHiddenTab = false
        presenter.loadFavoriteMovies()
    }
    
    private func configureInformationView() {
        informationContainerView.addRadius(cornerRadius: 12.0)
    }
    
    private func configureCollectionView() {
        favoriteMovieCollectionView.dataSource = self
        favoriteMovieCollectionView.delegate = self
        favoriteMovieCollectionView.backgroundColor = .clear
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        favoriteMovieCollectionView.showsVerticalScrollIndicator = true
        favoriteMovieCollectionView.collectionViewLayout = flowLayout
        favoriteMovieCollectionView.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        favoriteMovieCollectionView.register(
            FavoriteMovieCollectionViewCell.getNib(),
            forCellWithReuseIdentifier: FavoriteMovieCollectionViewCell.identifier
        )
    }
    
}

// MARK: - UICollectionViewDataSource

extension FavoriteMoviesViewController: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return presenter.favoriteMoviesCount
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteMovieCollectionViewCell.identifier, for: indexPath) as? FavoriteMovieCollectionViewCell else { return UICollectionViewCell(frame: .zero) }
        cell.setupCell(movie: presenter.getFavoriteMovie(at: indexPath.row))
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate

extension FavoriteMoviesViewController: UICollectionViewDelegate {
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        presenter.didTapFavoriteMovie(at: indexPath.row)
    }
    
}
    
// MARK: - UICollectionViewDelegateFlowLayout

extension FavoriteMoviesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 8
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 8
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(
            width: (collectionView.frame.size.width/2)-12,
            height: (collectionView.frame.size.width/2)-12
        )
    }
    
}

extension FavoriteMoviesViewController: FavoriteMoviesView {
    
    func showInformation(usingCase favoriteCases: FavoriteMoviesCases) {
        switch favoriteCases {
        case .withData:
            favoriteMovieCollectionView.isHidden = false
            informationContainerView.isHidden = true
        case .empty:
            favoriteMovieCollectionView.isHidden = true
            informationContainerView.isHidden = false
            informationImageView.image = UIImage(named: "ic-movie-app")!
            informationTitleLabel.text = "Sin favoritos"
            informationDescriptionLabel.text = "Debes agregar una pelīcula a favoritos para poder mostrarla aquí."
        }
    }
    
    func reloadCollectionView() {
        favoriteMovieCollectionView.reloadData()
    }
    
    func navigateToDetail(using movie: Movie) {
        let destinationViewController = MovieDetailConfigure.configure(movie: movie)
        navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
}
