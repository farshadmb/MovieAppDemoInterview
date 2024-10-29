//
//  MovieCoordinator.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/28/24.
//

import Foundation
import UIKit

final class MovieCoordinator: Coordinator {
    
    typealias ViewControlller = UINavigationController
    
    var viewController: ViewControlller
    let diFactory: MovieFactory
   
    deinit {
        print("Deinit MovieCoordinator")
    }
    
    init(viewController: ViewControlller, diFactory: MovieFactory) {
        self.viewController = viewController
        self.diFactory = diFactory
    }
    
    func start(animated: Bool) {
        guard let viewController = try? diFactory.makeMovieListViewController() else {
            fatalError("Could not create \(MovieListViewController.self)")
        }
        
        viewController.viewModel?.didSelectMovie = { [weak self] movie in
            self?.navigateToDetails(for: movie)
        }
        
        if let searchViewController = try? diFactory.makeMovieSearchViewController() {
            searchViewController.viewModel?.didSelectMovie = { [weak self] movieId in
                self?.navigateToDetails(forId: movieId)
            }
            let searchController = UISearchController(searchResultsController: searchViewController)
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.searchResultsUpdater = searchViewController
            viewController.navigationItem.searchController = searchController
            viewController.definesPresentationContext = true
        }
        self.viewController.pushViewController(viewController, animated: animated)
    }
    
    func navigateToDetails(forId id: Int) {
        guard let viewController = try? diFactory.makeMovieDetailViewController(withId: id) else {
            fatalError("Could not create \(MovieDetailViewController.self)")
        }
        self.viewController.pushViewController(viewController, animated: true)
    }
    
    func navigateToDetails(for movie: Movie) {
        guard let viewController = try? diFactory.makeMovieDetailViewController(with: movie) else {
            fatalError("Could not create \(MovieDetailViewController.self)")
        }
        self.viewController.pushViewController(viewController, animated: true)
    }
}
