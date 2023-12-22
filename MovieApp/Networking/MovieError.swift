//
//  MovieError.swift
//  MovieApp
//
//  Created by Carlos Enrrique Fuentes Rojas on 15/12/23.
//

import Foundation

enum MovieError: Error {
    
    case invalidUrl
    case apiError
    case dataError
    case parsingError(withMessage: String)
    
}
