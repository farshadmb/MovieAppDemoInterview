//
//  MovieDIContainer.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/28/24.
//

import Foundation
import UIKit

final class MovieDIContainer: MovieFactory {
  
    let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func makeMovieCoordinator(navigation: UINavigationController) -> MovieCoordinator {
        fatalError("not implemented")
    }
    
    func makeMovieListViewController() -> MovieListViewController {
        fatalError("not implemented")
    }
}
