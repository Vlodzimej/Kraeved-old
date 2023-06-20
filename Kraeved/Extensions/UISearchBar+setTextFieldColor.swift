//
//  UISearchBar+setTextFieldColor.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 30.04.2023.
//

import UIKit

extension UISearchBar {
    func setTextFieldColor(_ color: UIColor) {
        for subView in self.subviews {
            for subSubView in subView.subviews {
                let view = subSubView as? UITextInputTraits
                if view != nil {
                    let textField = view as? UITextField
                    textField?.backgroundColor = color
                    break
                }
            }
        }
    }
}
