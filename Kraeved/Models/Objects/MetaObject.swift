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
                return UUID(uuidString: "5c263f8b-a249-44fc-bad0-39aacde12f60")!
        }
    }
}

struct MetaObject<T: Codable>: Identifiable {
    var id: UUID
    var title: String?
    var image: UIImage?
    var data: T?
}
