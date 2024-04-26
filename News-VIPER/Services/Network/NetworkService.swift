//
//  NetworkService.swift
//  News-VIPER
//
//  Created by Mohamed Ali on 21/04/2024.
//

import Foundation
import Alamofire

public protocol NetworkServiceProtocol {
    func fetch<U: Endpoint, T: Decodable>(
        endpoint: U,
        expectedType: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    )
}

public final class NetworkService: NetworkServiceProtocol {
    
    public func fetch<U: Endpoint, T: Decodable>(endpoint: U, expectedType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let request = try? endpoint.asURLRequest() else {
            fatalError()
        }
        
        AF.request(request).validate().responseDecodable(queue: .global()) { (response: DataResponse<T, AFError>) in
            switch response.result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
