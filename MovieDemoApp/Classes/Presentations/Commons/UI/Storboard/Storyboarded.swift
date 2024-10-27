//
//  Storyboarded.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/27/24.
//

import Foundation
import UIKit

protocol Storyboarded: AnyObject {

    /// The storyboard identifier
    static var storyboardId: String { get }
    
    /// The storyboard name
    static var storyboardFilename: String { get }

    /**
     Instantiates the storyboard
     */
    static func instantiate() throws -> Self
    
}

/**
 The StoryboardedError represent the error occurred while try to instance `UIViewController` from storyboard.
 */
enum StoryboardedError: LocalizedError {
    
    /// The given Storyboard identifier not found.
    case notFound(String)

    /// Could not cast the created object into given type
    case casting(String)
}

extension UIViewController: Storyboarded {}

extension Storyboarded where Self: UIViewController {

    static var storyboardFilename: String { storyboardName }
    
    static var storyboardId: String { storyboardIdentifier }
    
    static func instantiate() throws -> Self {
        try instantiate(bundle: Bundle(for: self))
    }

    static func instantiate(bundle: Bundle = .main) throws -> Self {

        let storyboard = UIStoryboard(name: storyboardFilename, bundle: Bundle.main)
        let id = storyboardId.isEmpty ? className : storyboardId
        guard let viewController = storyboard.instantiateViewController(identifier: id) else {
            throw StoryboardedError.notFound("Could not find View Controller id \(id)")
        }

        guard let castedViewController = viewController as? Self else {
            throw StoryboardedError.casting("Could not cast ViewController \(viewController.className) into \(className)")
        }

        return castedViewController
    }

}
