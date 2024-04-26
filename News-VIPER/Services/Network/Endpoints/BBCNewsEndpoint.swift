//
//  BBCNewsEndpoint.swift
//  News-VIPER
//
//  Created by Noor El-Din Walid on 26/04/2024.
//

import Foundation
import Alamofire

enum BBCNewsEndpoint {
    case allNews
}

extension BBCNewsEndpoint: Endpoint {
    var headers: HTTPHeaders {
        return []
    }
    
    var path: String {
        switch self {
        case .allNews:
            return "/bbc-news.json"
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
