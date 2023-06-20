//
//  UIFont.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 30.04.2023.
//

import UIKit

extension UIFont {

    struct CustomFont {

        var fontFamily: String

        static let defaultFontSize: CGFloat = 12

        func Light(withSize size: CGFloat = CustomFont.defaultFontSize) -> UIFont {
            return UIFont(name: "\(String(describing: fontFamily))-Light", size: size) ?? UIFont.systemFont(ofSize: size)
        }

        func Regular(withSize size: CGFloat = CustomFont.defaultFontSize) -> UIFont {
            return UIFont(name: "\(String(describing: fontFamily))-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
        }

        func Bold(withSize size: CGFloat = CustomFont.defaultFontSize) -> UIFont {
            return UIFont(name: "\(String(describing: fontFamily))-Bold", size: size) ?? UIFont.systemFont(ofSize: size)
        }
        
        func SemiBold(withSize size: CGFloat = CustomFont.defaultFontSize) -> UIFont {
            return UIFont(name: "\(String(describing: fontFamily))-SemiBold", size: size) ?? UIFont.systemFont(ofSize: size)
        }
    }

    class var BeVietnamPro: CustomFont {
        return CustomFont(fontFamily: "BeVietnamPro")
    }
}
