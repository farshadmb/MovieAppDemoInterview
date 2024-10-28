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
    
    init(viewController: ViewControlller, diFactory: MovieFactory) {
        self.viewController = viewController
        self.diFactory = diFactory
    }
    
    func start(animated: Bool) {
        guard let viewController = try? diFactory.makeMovieListViewController() else {
            fatalError("Could not create \(MovieListViewController.self)")
        }
        
        if let searchViewController = try? diFactory.makeMovieSearchViewController() {
            let searchController = UISearchController(searchResultsController: searchViewController)
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.searchResultsUpdater = searchViewController
            viewController.navigationItem.searchController = searchController
            viewController.definesPresentationContext = true
        }
        self.viewController.pushViewController(viewController, animated: animated)
    }
}
