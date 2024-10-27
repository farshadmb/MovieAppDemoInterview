//
//  ApiRequest.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/27/24.
//

import Foundation

protocol ApiRequest {
    
    var acceptableStatusCodes: Set<Int> { get }
    var acceptableContentTypes: Set<String> { get }
    
    func asRequest() throws ->  URLRequest
}

extension ApiRequest {
    
    var acceptableStatusCodes: Set<Int> { Set(200..<300) }
    var acceptableContentType: Set<String> { Set(["application/json"]) }
}
