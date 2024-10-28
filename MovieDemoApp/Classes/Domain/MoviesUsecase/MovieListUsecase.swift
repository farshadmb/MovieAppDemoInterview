//
//  MovieListUsecase.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/28/24.
//

import Foundation
import RxSwift

protocol MovieListUsecase {
    
    func getMovieList(page: Int, size: Int) -> Single<[Movie]>
    
    func searchMovies(key: String, page: Int, size: Int) -> Single<[Movie]>
    
}
