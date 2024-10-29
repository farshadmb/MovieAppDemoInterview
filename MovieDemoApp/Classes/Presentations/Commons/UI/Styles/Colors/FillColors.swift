//
//  FillColors.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/29/24.
//

import Foundation
import UIKit

enum FillColors: Int, Color {
    
    case primary
    case secondary
    
    var color: UIColor {
        switch self {
        case .primary:
            return UIColor(lightHex: "#D8D8D8", darkHex: "#262626") ?? UIColor(rgb: 0xd8d8d8)
        case .secondary:
            return UIColor(lightHex: "#BFBFBF", darkHex: "#3F3F3F") ?? UIColor(rgb: 0xbfbfbf)
        }
    }
    
    var hexColor: String {
        color.hexString
    }
    
}

extension UIColor.Styles {
    
    static let primaryFill  = FillColors.primary.color
    static let secondaryFil = FillColors.secondary.color
}
