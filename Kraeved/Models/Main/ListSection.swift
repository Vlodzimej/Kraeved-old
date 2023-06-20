//
//  ListSection.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 20.06.2023.
//

import Foundation

enum ListSection {
    case stories([ListItem])
    
    var items: [ListItem] {
        switch self {
        case .stories(let items):
            return items
        }
    }
    
    var count: Int {
        items.count
    }
    
    var title: String {
        switch self {
        case .stories(_):
            return ""
        }
    }
}
