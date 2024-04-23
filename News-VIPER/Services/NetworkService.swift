//
//  NetworkService.swift
//  News-VIPER
//
//  Created by Mohamed Ali on 21/04/2024.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol {
    func requestCNNNews(completion: @escaping (Result<NewsResponse, Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    
    func requestCNNNews(completion: @escaping (Result<NewsResponse, Error>) -> Void ) {
        
        guard let url = URL(string: AppConstants.newsURL) else {
            return
        }
        
        let request = URLRequest(url: url)
        
        AF.request(request).validate().responseDecodable(queue: .global()) { (response: DataResponse<NewsResponse,AFError>) in
            switch response.result {
            case .success(let newsResponse):
                completion(.success(newsResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
