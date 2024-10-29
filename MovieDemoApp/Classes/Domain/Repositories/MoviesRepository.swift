//
//  MoviesRepository.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/28/24.
//

import Foundation
import RxSwift

protocol MoviesRepository {
    
    func movieList(page: Int, size: Int) -> Single<[Movie]>
    
    func searchMovieList(key: String, page: Int, size: Int) -> Single<[Movie]>
    
    func movieDetails(forId id: Int) -> Single<Movie>
}
