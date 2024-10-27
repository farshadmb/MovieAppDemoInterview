//
//  Coordinator.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/28/24.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    
    /// The view controller for the coordinator to display
    var viewController: UIViewController { get }
    
    /**
     The Coordinator takes control and activates itself.
     - Parameters:
     - animated: Set the value to true to animate the transition. Pass false if you are setting up a navigation controller before its view is displayed.
     */
    func start(animated: Bool)
    
}
