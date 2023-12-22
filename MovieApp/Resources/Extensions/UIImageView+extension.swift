//
//  UIImageView + extension.swift
//  MovieApp
//
//  Created by Carlos Enrrique Fuentes Rojas on 19/12/23.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    func loadImage(
        withURL imageUrl: String?,
        defaultImage: UIImage,
        backgroundColor: UIColor = .clear
    ) {
        self.backgroundColor = backgroundColor
        guard let imageURL = imageUrl,
              let url = URL(string: imageURL) else {
            self.image = defaultImage
            return
        }
        self.sd_setImage(with: url) { [weak self] (image, error, cacheType, url) in
            guard let self = self else { return }
            if let image = image {
                self.image = image
            } else {
                self.image = defaultImage
            }
        }
    }
    
}
    
