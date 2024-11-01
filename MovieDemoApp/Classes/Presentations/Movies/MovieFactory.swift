//
//  MovieFactory.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/28/24.
//

import Foundation

protocol MovieFactory {
    
    func makeMovieListViewController() throws -> MovieListViewController
    
    func makeMovieSearchViewController() throws -> MovieSearchViewController
    
    func makeMovieDetailViewController(withId id: Int) throws -> MovieDetailViewController
    
    func makeMovieDetailViewController(with movie: Movie) throws -> MovieDetailViewController
}
