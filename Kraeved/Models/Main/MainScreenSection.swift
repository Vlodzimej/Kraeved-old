//
//  ListSection.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 20.06.2023.
//

import Foundation

enum MainScreenSection {
    case stories([MainScreenSectionItem])
    case annotations([MainScreenSectionItem])
    
    var items: [MainScreenSectionItem] {
        switch self {
        case .stories(let items):
            return items
        case .annotations(let items):
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
        case .annotations(_):
            return "Места"
        }
    }
}
