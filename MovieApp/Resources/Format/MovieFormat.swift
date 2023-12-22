//
//  MovieFormat.swift
//  MovieApp
//
//  Created by Luis Angel Inga Mendoza on 21/12/23.
//

import Foundation

class MovieFormat {
    
    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "es_PE")
        dateFormatter.amSymbol = "am"
        dateFormatter.pmSymbol = "pm"
        return dateFormatter
    }()
    
    static func format(
        fromDate: String,
        fromFormat: String,
        toFormat: String
    ) -> String {
        dateFormatter.dateFormat = fromFormat
        guard let initialDate = dateFormatter.date(from: fromDate) else {
            return fromDate
        }
        dateFormatter.dateFormat = toFormat
        return dateFormatter.string(from: initialDate)
    }
    
}
