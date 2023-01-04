//
//  format.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 04.01.2023.
//

import Foundation

func formatPhoneNumber(with mask: String, phone: String) -> String {
    let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
    var result = ""
    var index = numbers.startIndex

    for char in mask where index < numbers.endIndex {
        if char == "X" {
            result.append(numbers[index])
            index = numbers.index(after: index)
        } else {
            result.append(char)
        }
    }
    return result
}
