//
//  ApiClientAuthenticator.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/27/24.
//

import Foundation

protocol ApiInterceptor {
    
    func authenticate(request: URLRequest) throws -> URLRequest
}
