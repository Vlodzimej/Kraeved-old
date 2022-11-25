//
//  Picture.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 22.11.2022.
//

import UIKit

enum MetaType: String {
    case historicalEvent = "5c263f8b-a249-44fc-bad0-39aacde12f60"
    case picture = "7a780bdb-0357-40d5-b9a0-d5fcb79da6fd"
    case annotation = "a9d0150e-4d0e-4804-83c6-df3c5764efc7"
}

struct MetaObject<T: Codable>: Identifiable {
    var id: UUID
    var title: String?
    var image: UIImage?
    var data: T?
}

