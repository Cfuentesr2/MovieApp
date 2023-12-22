//
//  MovieTableViewCell.swift
//  MovieApp
//
//  Created by Carlos Enrrique Fuentes Rojas on 18/12/23.
//

import UIKit
import SDWebImage

class MovieTableViewCell: UITableViewCell {

    static let identifier = "MovieTableViewCell"
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.addRadius()
    }
    
    func setupCell(movie: Movie) {
        movieImageView.loadImage(
            withURL: movie.posterImageUrl,
            defaultImage: UIImage(named: "ic-film")!
        )
        titleLabel.text = movie.title
        descriptionLabel.text = movie.description
        releaseDateLabel.text = "F. Lanzamiento: \(MovieFormat.format(fromDate: movie.releaseDate, fromFormat: "yyyy-MM-dd", toFormat: "dd/MM/yyyy"))"
    }
    
    static func getNib() -> UINib {
        return UINib(
            nibName: MovieTableViewCell.identifier,
            bundle: Bundle(for: MovieTableViewCell.self)
        )
    }
    
}
