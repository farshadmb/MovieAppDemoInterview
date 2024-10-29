//
//  MovieListUsecaseImp.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/28/24.
//

import Foundation
import RxSwift

final class MovieListUsecaseImp: MovieListUsecase {
    
    let repository: MoviesRepository
    
    init(repository: MoviesRepository) {
        self.repository = repository
    }
    
    func getMovieList(page: Int, size: Int) -> Single<[Movie]> {
        repository.movieList(page: page, size: size)
    }
    
    func searchMovies(key: String, page: Int, size: Int) -> Single<[Movie]> {
        repository.searchMovieList(key: key, page: page, size: size)
    }
    
}
