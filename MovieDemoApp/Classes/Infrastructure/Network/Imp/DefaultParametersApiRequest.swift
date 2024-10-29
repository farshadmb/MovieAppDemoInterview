//
//  DefaultParametersApiRequest.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/27/24.
//

import Foundation
import Alamofire

struct DefaultParametersApiRequest: ApiRequest {
    
    let url: URL
    
    let method: HTTPMethod
    
    let parameters: [String: Any]?
    
    let encoding: ParameterEncoding
    
    let headers: [String: String]
    
    let acceptableStatusCodes: Set<Int>
    
    let acceptableContentTypes: Set<String>
    
    init(url: URL,
         method: HTTPMethod,
         parameters: [String: Any]? = nil,
         encoding: ParameterEncoding = URLEncoding.default,
         headers: [String: String] = [:],
         acceptableStatusCodes: Set<Int> = Self.acceptableStatusCodes,
         acceptableContentTypes: Set<String> = Self.acceptableContentTypes) {
        self.url = url
        self.method = method
        self.parameters = parameters
        self.encoding = encoding
        self.headers = headers
        self.acceptableStatusCodes = acceptableStatusCodes
        self.acceptableContentTypes = acceptableContentTypes
    }
    
    func asRequest() throws -> URLRequest {
        let acceptHeader = HTTPHeader(name: "Accept", value: acceptableContentTypes.joined(separator: ", "))
        var requestHeaders = HTTPHeaders([acceptHeader])
        requestHeaders.add(acceptHeader)
        headers.map {
            HTTPHeader(name: $0.key, value: $0.value)
        }.forEach {
            requestHeaders.add($0)
        }
        
        let request = try URLRequest(url: url, method: method, headers: requestHeaders)
        return try encoding.encode(request, with: parameters)
    }
}
