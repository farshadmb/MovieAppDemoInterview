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
    
    lazy var movieDetailUsecase: MovieDetailUsecase = {
       MovieDetailUsecaseImp(repository: makeMoviesRepository())
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
   
    func makeMovieSearchViewController() throws -> MovieSearchViewController {
        let viewController = MovieSearchViewController()
        let viewModel = MovieSearchViewModel(usecase: movieUsecase)
        viewController.bind(to: viewModel)
        return viewController
    }
   
    func makeMovieDetailViewController(withId id: Int) throws -> MovieDetailViewController {
        let viewController = try MovieDetailViewController.instantiate()
        let viewModel = MovieDetailsViewModel(movieId: id, useCase: movieDetailUsecase)
        viewController.bind(to: viewModel)
        return viewController
    }
    
    func makeMovieDetailViewController(with movie: Movie) throws -> MovieDetailViewController {
        let viewController = try MovieDetailViewController.instantiate()
        let viewModel = MovieDetailsViewModel(entity: movie, useCase: movieDetailUsecase)
        viewController.bind(to: viewModel)
        return viewController
    }
    // MARK: - Repositories
    func makeMoviesRepository() -> MoviesRepository {
        RemoteMoviesRepository(apiClient: apiClient, baseURL: AppConfig.baseURL)
    }
    
}
