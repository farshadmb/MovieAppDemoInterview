//
//  Color.swift
//  MovieDemoApp
//
//  Created by Farshad Mousalou on 10/29/24.
//

import Foundation
import UIKit

protocol Color {
    
    /// the `UIColor` value for current color object.
    var color: UIColor { get }
    
    /// the `String` value indicate the hexadecimal for color object.
    var hexColor: String { get }
    
}

extension String: Color {}

extension Color where Self: StringProtocol {
    
    var color: UIColor {
        #if !TARGET_INTERFACE_BUILDER
        let selfStr = String(self)
        switch selfStr.first {
        case "#": // use case "#AAAAAA".color
            guard let color = UIColor(hexString: selfStr) else {
                assertionFailure("Color is not in hexdecimal")
                return .systemPink
            }
            return color
        case "0": // use case "0xAA2A3B".color
            guard let intDecimal = UInt64(selfStr) else {
                return .blue
            }
            return UIColor(rgb: intDecimal)
        default:
            guard let color = UIColor(named: String(self)) else {
                assertionFailure("Color missing from asset catalogue")
                return .systemPink
            }
            return color
        }

        #else
        print(UIColor(named: String(self), in: Bundle(for: AppDelegate.self), compatibleWith: nil))
        guard let color = UIColor(named: String(self), in: Bundle(for: AppDelegate.self), compatibleWith: nil) else {
            assertionFailure("Color missing from asset catalogue")
            return .systemPink
        }
        return color
        #endif
    }
    
    var hexColor: String {
        return color.hexString
    }
}

extension Color where Self: Equatable {

    static func ==(lhs: Color, rhs: Color) -> Bool {
        return type(of: lhs) == type(of: rhs) && lhs.hexColor == rhs.hexColor
    }
}
