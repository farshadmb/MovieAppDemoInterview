//
//  MoviesRequestEndpoint.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/28/24.
//

import Foundation

enum MoviesRequestEndpoint {
    
    case movieList(page: Int)
    case searchMovie(query: String, page: Int)
    case movieDetail(id: Int)
    
    var path: String {
        switch self {
        case .movieList:
            "movie/popular"
        case .searchMovie:
            "search/movie"
        case .movieDetail(let id):
            "movie/:id".replacingOccurrences(of: ":id", with: "\(id)")
        }
    }
    
    var params: [String: Any]? {
        switch self {
        case .movieList(let page): ["page": page]
        case .searchMovie(let query, let page): ["page": page, "query": query]
        case .movieDetail: nil
        }
    }
    
    var acceptableStatusCodes: Set<Int> {
        // see https://developer.themoviedb.org/docs/errors
        Set(200..<300).union([401, 403, 404, 405, 405, 429, 422, 500, 501, 502])
    }
    
    func request(baseURL: URL) throws -> ApiRequest {
        guard let url = URL(string: baseURL.absoluteString + path) else {
            throw URLError(.badURL)
        }
        let request = DefaultParametersApiRequest(url: url,
                                                  method: .get,
                                                  parameters: params,
                                                  acceptableStatusCodes: acceptableStatusCodes)
        return request
    }
}
