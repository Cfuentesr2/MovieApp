//
//  BaseRequest.swift
//  MovieApp
//
//  Created by Carlos Enrrique Fuentes Rojas on 15/12/23.
//

import Foundation

protocol BaseRequest {
    
    associatedtype Response
    
    var baseUrl: String { get }
    var service: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var queryItems: [String: String] { get set }
    
    func decode(_ data: Data) throws -> Response
    
}

extension BaseRequest where Response: Decodable {
    
    func decode(_ data: Data) throws -> Response {
        let decoder = JSONDecoder()
        return try decoder.decode(Response.self, from: data)
    }
    
}
