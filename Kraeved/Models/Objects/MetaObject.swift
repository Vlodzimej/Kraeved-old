//
//  MetaObject.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 22.11.2022.
//

import UIKit

enum MetaType: String {
    case entity = "5C263F8B-A249-44FC-BAD0-39AACDE12F60"

    var id: UUID {
        guard let uuid = UUID(uuidString: self.rawValue) else {
            debugPrint("Can't create MetaType UUID")
            return UUID()
        }
        return uuid
    }
}

struct MetaObject<T: Codable>: Identifiable {
    var id: UUID
    var title: String?
    var image: UIImage?
    var data: T?
    
    func convertToBusinessObject() -> BusinessObject? {
        var metaTypeId: UUID?
        switch T.self {
            case is Entity.Type:
                metaTypeId = MetaType.entity.id
            default:
                break
        }
        
        guard let data = try? JSONEncoder().encode(data),
              let customProperties = String(data: data, encoding: .utf8) else { return nil }

        return BusinessObject(id: id, title: title, metaTypeId: metaTypeId, customProperties: customProperties, startDate: nil, finishDate: nil)
    }
}
