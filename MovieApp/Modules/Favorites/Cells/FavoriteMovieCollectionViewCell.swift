//
//  FavoriteMovieCollectionViewCell.swift
//  MovieApp
//
//  Created by Carlos Enrrique Fuentes Rojas on 20/12/23.
//

import UIKit

final class FavoriteMovieCollectionViewCell: UICollectionViewCell {

    static let identifier = "FavoriteMovieCollectionViewCell"

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.addRadius(cornerRadius: 12.0)
    }
    
    func setupCell(movie: Movie) {
        imageView.loadImage(
            withURL: movie.posterImageUrl,
            defaultImage: UIImage(named: "ic-film")!
        )
        titleLabel.text = movie.title
    }
    
    static func getNib() -> UINib {
        return UINib(
            nibName: FavoriteMovieCollectionViewCell.identifier,
            bundle: Bundle(for: FavoriteMovieCollectionViewCell.self)
        )
    }

}
