//
//  MovieFactory.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/28/24.
//

import Foundation

protocol MovieFactory {
    
    func makeMovieListViewController() throws -> MovieListViewController
}
