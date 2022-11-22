//
//  Picture.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 22.11.2022.
//

import UIKit

enum Metatype {
    case historicalEvent
    case picture
    case annotation
}

struct MetaObject<T: Codable>: Identifiable {
    var id: UUID
    var title: String?
    var image: UIImage?
    var data: T?
}

struct BusinessObject {
    var id: UUID
    var name: String?
    var title: String?
    var metatype: Metatype
    var content: String?
    
    func convertToMetaObject<T: Codable>() -> MetaObject<T> {
        guard let json = content?.data(using: .utf8)! else { return MetaObject(id: id) }
        let decoder = JSONDecoder()
        var result: MetaObject<T>
        do {
            let data = try decoder.decode(T.self, from: json)
            result = MetaObject(id: id, title: title, image: nil, data: data)
        }
        catch {
            debugPrint(error)
            return MetaObject(id: id)
        }
        return result
    }
}
