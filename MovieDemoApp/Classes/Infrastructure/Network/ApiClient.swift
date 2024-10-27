//
//  ApiClient.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/27/24.
//

import Foundation

protocol ApiClient {
    
    typealias Completion<T> = (_ response: Result<T, Error>) -> Void
    
    func sendRequest<Req: ApiRequest, Res>(request: Req, completion: @escaping Completion<Res>) -> ApiTaskCancelable
}
