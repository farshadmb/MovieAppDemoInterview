//
//  RemoteMoviesRepository.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/28/24.
//

import Foundation
import RxSwift

final class RemoteMoviesRepository: MoviesRepository {
    
    let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func movieList(page: Int, size: Int) -> Single<[Movie]> {
        fatalError("not implemtend")
    }
    
    func searchMovieList(key: String, page: Int, size: Int) -> Single<[Movie]> {
        fatalError("not implemtend")
    }
}
