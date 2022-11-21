//
//  UIColor+extra.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 21.11.2022.
//

import UIKit

extension UIColor {
    
    convenience init(hex hexValue: Int64) {
        let red = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hexValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hexValue & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
    
    struct MainScreen {
        static var background: UIColor { UIColor.HEX.hFF3B30 }
    }
}

extension UIColor {
    fileprivate struct HEX {
        static let hFF3B30 = UIColor(hex: 0xAFD5F0)
    }
}
