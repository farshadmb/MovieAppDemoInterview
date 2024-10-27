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
       fatalError("not implemented")
    }
}
