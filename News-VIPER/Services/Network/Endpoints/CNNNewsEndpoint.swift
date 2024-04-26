//
//  CNNNews.swift
//  News-VIPER
//
//  Created by Noor El-Din Walid on 26/04/2024.
//

import Foundation
import Alamofire

enum CNNNewsEndpoint {
    case allNews
}

extension CNNNewsEndpoint: Endpoint {
    var headers: HTTPHeaders {
        return []
    }
    
    var path: String {
        switch self {
        case .allNews:
            return "/cnn.json"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .allNews:
                .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .allNews:
            return nil
        }
    }
}
