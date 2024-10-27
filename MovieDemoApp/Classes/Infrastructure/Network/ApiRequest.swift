//
//  ApiRequest.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/27/24.
//

import Foundation

protocol ApiRequest {
    
    func asRequest() throws ->  URLRequest
}
