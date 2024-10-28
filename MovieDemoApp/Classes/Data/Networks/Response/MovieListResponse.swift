//
//  MovieListResponse.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/28/24.
//

import Foundation

struct MovieListResponse: Decodable {
    
    let page: Int
    let results: [MovieDto]
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
    }
}
