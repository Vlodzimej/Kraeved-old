//
//  UIView+addGradientWithColor.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 21.11.2022.
//

import UIKit

extension UIView {
    func addGradientWithColor(color: UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [UIColor.clear.cgColor, color.cgColor]

        self.layer.insertSublayer(gradient, at: 0)
    }
}
