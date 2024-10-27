//
//  DefaultEncodableApiRequest.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/27/24.
//

import Foundation
import Alamofire

struct DefaultEncodableApiRequest<Parameters: Encodable>: ApiRequest {
    
    let url: URL
    
    let method: HTTPMethod
    
    let parameters: Parameters?
    
    let encoder: ParameterEncoder
    
    var acceptableStatusCodes: Set<Int>
    
    var acceptableContentTypes: Set<String>
    
    let headers: [String: String]
    
    init(url: URL, method: HTTPMethod = .get,
         parameters: Parameters? = nil,
         encoder: ParameterEncoder = JSONParameterEncoder.default,
         headers: [String: String] = [:],
         acceptableStatusCodes: Set<Int> = Self.acceptableStatusCodes,
         acceptableContentTypes: Set<String> = Self.acceptableContentTypes) {
        self.url = url
        self.method = method
        self.parameters = parameters
        self.encoder = encoder
        self.headers = headers
        self.acceptableStatusCodes = acceptableStatusCodes
        self.acceptableContentTypes = acceptableContentTypes
    }
    
    // MARK: - ApiRequest
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
        return try parameters.map { try encoder.encode($0, into: request) } ?? request
    }
}
