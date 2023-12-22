//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Carlos Enrrique Fuentes Rojas on 15/12/23.
//

import UIKit

enum MoviesCases {
    
    case withData
    case empty
    case error
    
}

protocol HomeView: AnyObject {
    
    func showProgress(withNewData: Bool)
    func hideProgress()
    func reloadTableView()
    func showInformation(usingCase movieCases: MoviesCases)
    func navigateToDetail(using movie: Movie)
    
}

final class HomeViewController: UIViewController {

    static let identifier = "HomeViewController"
    
    @IBOutlet weak var informationContainerView: UIView!
    @IBOutlet weak var informationImageView: UIImageView!
    @IBOutlet weak var informationTitleLabel: UILabel!
    @IBOutlet weak var informationDescriptionLabel: UILabel!
    @IBOutlet weak var movieTableView: UITableView!
    
    var presenter: HomePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInformationView()
        configureTableView()
        presenter.loadMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        (self.tabBarController as? MovieTabBarController)?.isHiddenTab = false
    }
    
    private func configureInformationView() {
        informationContainerView.addRadius(cornerRadius: 12.0)
    }
    
    private func configureTableView() {
        movieTableView.register(
            MovieTableViewCell.getNib(),
            forCellReuseIdentifier: MovieTableViewCell.identifier
        )
        movieTableView.dataSource = self
        movieTableView.delegate = self
    }
    
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return presenter.movieListCount
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MovieTableViewCell.identifier,
            for: indexPath
        ) as? MovieTableViewCell else { return UITableViewCell(frame: .zero) }
        cell.setupCell(movie: presenter.getMovie(at: indexPath.row))
        return cell
    }
    
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        presenter.didTapMovie(at: indexPath.row)
    }
    
    func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        if (indexPath.row + 1) == presenter.movieListCount {
            presenter.loadMoreMovies()
        }
    }
    
}

extension HomeViewController: HomeView {
    
    func showProgress(withNewData: Bool) {
        ProgressView.shared.showProgressView(in: self.view)
        movieTableView.isHidden = !withNewData
        informationContainerView.isHidden = true
    }
    
    func hideProgress() {
        ProgressView.shared.hideProgressView()
    }
    
    func reloadTableView() {
        movieTableView.reloadData()
    }
    
    func showInformation(usingCase movieCases: MoviesCases) {
        switch movieCases {
        case .withData:
            movieTableView.isHidden = false
            informationContainerView.isHidden = true
        case .empty:
            movieTableView.isHidden = true
            informationContainerView.isHidden = false
            informationImageView.image = UIImage(named: "ic-movie-app")!
            informationTitleLabel.text = "Sin peliculas"
            informationDescriptionLabel.text = "No tenemos ninguna pelicula por mostrar."
        case .error:
            movieTableView.isHidden = true
            informationContainerView.isHidden = false
            informationImageView.image = UIImage(named: "ic-movie-app")!
            informationTitleLabel.text = "Ha ocurrido un error"
            informationDescriptionLabel.text = "Estamos presentando problemas para mostrar la lista de películas, intentelo mas tarde."
        }
    }
    
    func navigateToDetail(using movie: Movie) {
        let destinationViewController = MovieDetailConfigure.configure(movie: movie)
        navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
}
