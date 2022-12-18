//
//  MetaObject.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 22.11.2022.
//

import UIKit

enum MetaType {
    case entity

    var id: UUID {
        switch self {
            case .entity:
                return UUID(uuidString: "5C263F8B-A249-44FC-BAD0-39AACDE12F60")!
        }
    }
}

struct MetaObject<T: Codable>: Identifiable {
    var id: UUID
    var title: String?
    var image: UIImage?
    var data: T?
}
