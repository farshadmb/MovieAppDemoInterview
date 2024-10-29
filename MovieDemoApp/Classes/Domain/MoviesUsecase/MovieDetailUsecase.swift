//
//  MovieDetailUsecase.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/29/24.
//

import Foundation
import RxSwift

protocol MovieDetailUsecase {
    
    func getMovieDetail(forId id: Int) -> Single<Movie>
    
}
