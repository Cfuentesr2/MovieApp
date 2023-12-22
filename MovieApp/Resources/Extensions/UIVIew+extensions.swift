//
//  UIVIew + extensions.swift
//  MovieApp
//
//  Created by Carlos Enrrique Fuentes Rojas on 19/12/23.
//

import UIKit

extension UIView {
    
    func addRadius(cornerRadius: CGFloat = 8.0) {
        layer.cornerRadius = cornerRadius
    }
    
    func addBorder(
        with color: UIColor,
        width: CGFloat = 1,
        cornerRadius: CGFloat = 8.0
    ) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
        layer.cornerRadius = cornerRadius
    }
    
}
