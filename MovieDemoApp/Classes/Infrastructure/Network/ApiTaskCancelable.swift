//
//  ApiTaskCancelable.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/27/24.
//

import Foundation
import Alamofire

protocol ApiTaskCancelable {
    
    func cancel()
}

extension URLSessionTask: ApiTaskCancelable {}
extension Alamofire.Request: ApiTaskCancelable {
    
    func cancel() {
        task?.cancel()
    }
}
