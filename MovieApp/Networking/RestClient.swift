//
//  RestClient.swift
//  MovieApp
//
//  Created by Carlos Enrrique Fuentes Rojas on 15/12/23.
//

import Foundation

final class RestClient {
    
    static let sharedInstance = RestClient()
    
    private init(){ }
    
    private var urlSession: URLSession = {
        let urlSessionConfiguration = URLSessionConfiguration.default
        urlSessionConfiguration.timeoutIntervalForRequest = 30
        urlSessionConfiguration.timeoutIntervalForResource = 30
        return URLSession(configuration: urlSessionConfiguration)
    }()
    
    func request<AnyRequest: BaseRequest>(
        _ request: AnyRequest,
        completion: @escaping (Result<AnyRequest.Response, MovieError>) -> Void
    ) {
        // Get URL
        guard var urlComponent = URLComponents(string: "\(request.baseUrl)\(request.service)\(request.path)") else {
            completion(.failure(.invalidUrl))
            return
        }
        // Set querys
        var queryItems: [URLQueryItem] = []
        queryItems.append(contentsOf: request.queryItems.map{ URLQueryItem(name: $0.key, value: $0.value) })
        urlComponent.queryItems = queryItems
        // URL request
        var urlRequest = URLRequest(url: urlComponent.url!)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        // Data Task
        urlSession.dataTask(with: urlRequest) { data, response, error in
            DispatchQueue.main.async {
                if error != nil {
                    return completion(.failure(.apiError))
                }
                guard let httpResponse = response as? HTTPURLResponse else {
                    return completion(.failure(.apiError))
                }
                switch httpResponse.statusCode {
                case 200..<300:
                    guard let data = data else {
                        return completion(.failure(.dataError))
                    }
                    do {
                        try completion(.success(request.decode(data)))
                    } catch let error {
                        completion(.failure(.parsingError(withMessage: "Failed parsing object with error:: \(error.localizedDescription)")))
                    }
                default:
                    completion(.failure(.apiError))
                }
            }
        }.resume()
    }
    
}
