//
//  MovieDetailUsecaseImp.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/29/24.
//

import Foundation
import RxSwift

final class MovieDetailUsecaseImp: MovieDetailUsecase {
    
    let repository: MoviesRepository
    
    init(repository: MoviesRepository) {
        self.repository = repository
    }
    
    func getMovieDetail(forId id: Int) -> Single<Movie> {
        repository.movieDetails(forId: id)
    }
    
}
