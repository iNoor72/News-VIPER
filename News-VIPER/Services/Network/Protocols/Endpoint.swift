//
//  Endpoint.swift
//  News-VIPER
//
//  Created by Noor El-Din Walid on 26/04/2024.
//

import Foundation
import Alamofire

public protocol Endpoint: URLRequestConvertible {
    var baseURL: URL { get }
    var requestURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var headers: HTTPHeaders { get }
    var encoding: ParameterEncoding { get }
}

extension Endpoint {
    var baseURL: URL {
        guard let url = URL(string: AppConstants.baseURL) else {
            fatalError()
        }
        
        return url
    }
    
    var requestURL: URL {
        baseURL.appendingPathComponent(path)
    }
    
    var encoding: ParameterEncoding {
        switch method {
        case .post:
            return JSONEncoding.default
        default:
            return URLEncoding.default
        }
    }
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: requestURL)
        request.headers = headers
        request.httpMethod = method.rawValue
        return request
    }
    
    func asURLRequest() throws -> URLRequest {
        try encoding.encode(urlRequest, with: parameters)
    }
}
