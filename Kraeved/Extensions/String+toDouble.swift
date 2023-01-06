//
//  String+toDouble.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 06.01.2023.
//

import Foundation

extension String {
    public func toDouble() -> Double? {
        if let num = NumberFormatter().number(from: self) {
                return num.doubleValue
            } else {
                return nil
            }
    }
}
