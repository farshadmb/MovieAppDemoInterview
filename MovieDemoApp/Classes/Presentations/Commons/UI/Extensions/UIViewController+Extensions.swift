//
//  UIViewController+Extensions.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/27/24.
//

import Foundation
import UIKit

extension UIViewController {

    @objc
    open class var storyboardName: String {
        return "Main"
    }

    class var className: String {
        return String(describing: self)
    }
    
    class var storyboardIdentifier: String {
        return className
    }
    
    var className: String {
        return String(describing: self)
    }
}
