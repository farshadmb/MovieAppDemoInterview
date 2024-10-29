//
//  BackgroundColors.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/29/24.
//

import Foundation
import UIKit

enum BackgroundColors: Int, Color {

   case `default`
   case primaryGrouped
   case secondaryGrouped
    
    var color: UIColor {
        switch self {
        case .default:
            return UIColor(lightHex: "#F2F2F2", darkHex: "#0C0C0C") ?? UIColor(rgb: 0xf2f2f2)
        case .primaryGrouped:
            return UIColor(lightHex: "#FFFFFF", darkHex: "#191919") ?? UIColor(rgb: 0xffffff)
        case .secondaryGrouped:
            return UIColor(lightHex: "#FFFFFF", darkHex: "#000000") ?? UIColor(rgb: 0xffffff)
        }
    }
    
    var hexColor: String {
        color.hexString
    }
}

enum OtherColors: Int, Color {
    
    case separator
    case shadow
    
    var color: UIColor {
        switch self {
        case .separator:
            return UIColor(lightHex: "#D8D8D8", darkHex: "") ?? UIColor(rgb: 0xd8d8d8 )
        case .shadow:
            return UIColor(lightHex: "#000000", darkHex: "") ?? UIColor(rgb: 0x000000)
        }
    }
    
    var hexColor: String {
        color.hexString
    }
}

extension UIColor.Styles {
    
    static let `default` = BackgroundColors.default.color
    static let primaryGroupedBackground   = BackgroundColors.primaryGrouped.color
    static let secondaryGroupedBackground = BackgroundColors.secondaryGrouped.color
    static let separator                  = OtherColors.separator.color
    static let shadow                     = OtherColors.shadow.color
}
