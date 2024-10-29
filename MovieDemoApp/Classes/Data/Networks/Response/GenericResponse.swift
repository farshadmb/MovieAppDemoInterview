//
//  GenericResponse.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/28/24.
//

import Foundation

struct GenericResponse<T: Decodable>: Decodable {
    
    let success: Bool
    let data: T?
    
    enum CodingKeys: String, CodingKey {
        case success
        case message = "status_message"
        case code = "status_code"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.success = try container.decodeIfPresent(Bool.self, forKey: .success) ?? true
        guard success else {
            let message = try container.decode(String.self, forKey: .message)
            let code = try container.decode(Int.self, forKey: .code)
            throw GenericResponse.serverError(statusCode: code, message: message)
        }
        data = try T.init(from: decoder)
    }
    
}

extension GenericResponse {
    
    enum GenericResponse: LocalizedError {
        case serverError(statusCode: Int, message: String)
        
        var localizedDescription: String {
            switch self {
            case .serverError(let statusCode, let message):
                return "\(message) code: \(statusCode)"
            }
        }
        
        var errorDescription: String? { localizedDescription }
    }
    
}
