//
//  DefaultApiClientAuthenticator.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/27/24.
//

import Foundation
import Alamofire

final class DefaultApiClientAuthenticator: ApiClientAuthenticator {
    
    let apiToken: String
    
    init(apiToken: String) {
        self.apiToken = apiToken
    }
    
    func authenticate(request: URLRequest) throws -> URLRequest {
        var newURLRequest = request
        guard !apiToken.isEmpty else {
            throw DefaultApiClientAuthenticatorError.missedAPIToken
        }
        // default url request
        newURLRequest.setValue("Bearer \(apiToken)", forHTTPHeaderField: "Authorization")
        // alamofire extensions
        newURLRequest.headers.update(.authorization(bearerToken: apiToken))
        return newURLRequest
    }
    
}

extension DefaultApiClientAuthenticator {
    
    enum DefaultApiClientAuthenticatorError: LocalizedError {
        case missedAPIToken
        
        var localizedDescription: String {
            switch self {
            case .missedAPIToken:
                return "Missed API Key Token"
            }
        }
        
        var errorDescription: String? {
            localizedDescription
        }
    }
    
}
