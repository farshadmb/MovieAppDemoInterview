//
//  AppCoordinator.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/28/24.
//

import Foundation
import UIKit

final class AppCoordinator: Coordinator {
   
    typealias ViewControlller = UINavigationController
    
    var viewController: ViewControlller
    let diContainer: AppDIContainer
    
    init(viewController: ViewControlller, diContainer: AppDIContainer) {
        self.viewController = viewController
        self.diContainer = diContainer
    }
    
    func start(animated: Bool = false) {
        let container = diContainer.makeMovieDIContainer()
        let movieCoordinator = container.makeMovieCoordinator(navigation: viewController)
        movieCoordinator.start(animated: animated)
    }
}
