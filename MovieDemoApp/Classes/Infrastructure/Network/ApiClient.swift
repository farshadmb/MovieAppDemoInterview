//
//  ApiClient.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/27/24.
//

import Foundation

protocol ApiClient {
    
    typealias Completion<T> = (_ response: Result<T, Error>) -> Void
    
    func sendRequest<Req: ApiRequest, Res: Decodable>(request: Req,
                                                      completion: @escaping Completion<Res>) throws -> ApiTaskCancelable
    
    func sendRequest<Req: ApiRequest>(request: Req,
                                      completion: @escaping Completion<Data>) throws -> ApiTaskCancelable
}
