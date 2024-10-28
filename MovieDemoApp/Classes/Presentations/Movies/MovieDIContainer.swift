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
    
    // MARK: - Usecases
    lazy var movieUsecase: MovieListUsecase = {
        MovieListUsecaseImp(repository: makeMoviesRepository())
    }()
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
   
    // MARK: - Flow Coordinators
    func makeMovieCoordinator(navigation: UINavigationController) -> MovieCoordinator {
        MovieCoordinator(viewController: navigation, diFactory: self)
    }
    
    // MARK: - MovieFactory
    func makeMovieListViewController() throws -> MovieListViewController {
        let viewController = try MovieListViewController.instantiate()
        let viewModel = MovieListViewModel(movieListUsecase: movieUsecase)
        viewController.bind(to: viewModel)
        return viewController
    }
    
    // MARK: - Repositories
    func makeMoviesRepository() -> MoviesRepository {
        RemoteMoviesRepository(apiClient: apiClient, baseURL: AppConfig.baseURL)
    }
    
}
