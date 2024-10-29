//
//  DefaultApiClient.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/27/24.
//

import Foundation
import Alamofire

final class DefaultApiClient: ApiClient {
    
    private let session: Alamofire.Session
    
    private let serializeWorkQueue: DispatchQueue
    
    typealias ResultType<T> = (Result<T, Error>) -> Void
    
    private var authenticator: ApiClientAuthenticator?
    
    private let lock = NSLock()
    
    deinit {
        authenticator = nil
    }
    
    init(configuration: URLSessionConfiguration, authenticator: ApiClientAuthenticator? = nil) {
        let queue = DispatchQueue(label: "DefaultApiClient.serializeQueue", attributes: .concurrent)
        self.authenticator = authenticator
        self.session = Alamofire.Session(configuration: configuration, serializationQueue: queue)
        self.serializeWorkQueue = queue
    }
    
    func set(authenticator newAuthenticator: ApiClientAuthenticator?) {
        lock.lock()
        defer { lock.unlock() }
        self.authenticator = newAuthenticator
    }
    
    func sendRequest<Req: ApiRequest, Res: Decodable>(request: Req,
                                                      completion: @escaping Completion<Res>) throws -> ApiTaskCancelable {
        var urlRequest = try request.asRequest()
        try authenticate(request: &urlRequest)
        return session.request(urlRequest)
            .validate(statusCode: request.acceptableStatusCodes)
            .validate(contentType: request.acceptableContentTypes)
            #if DEBUG
            .responseString(queue: serializeWorkQueue) { response in print(response.debugDescription) }
            #endif
            .responseDecodable(of: Res.self, queue: serializeWorkQueue) { response in
                switch response.result {
                case .success(let success):
                    completion(.success(success))
                case .failure(let failure):
                    completion(.failure(failure))
                }
            }
    }
    
    func sendRequest<Req: ApiRequest>(request: Req,
                                      completion: @escaping Completion<Data>) throws -> ApiTaskCancelable {
        var urlRequest = try request.asRequest()
        try authenticate(request: &urlRequest)
        return session.request(urlRequest)
            .validate(statusCode: request.acceptableStatusCodes)
            .validate(contentType: request.acceptableContentTypes)
            #if DEBUG
            .responseString(queue: serializeWorkQueue) { response in print(response.debugDescription) }
            #endif
            .responseData(queue: serializeWorkQueue) { response in
                switch response.result {
                case .success(let success):
                    completion(.success(success))
                case .failure(let failure):
                    completion(.failure(failure))
                }
            }
    }
    
    private func authenticate(request: inout URLRequest) throws {
        guard let authenticator = authenticator else {
            return
        }
        lock.lock()
        defer { lock.unlock() }
        request = try authenticator.authenticate(request: request)
    }
}
