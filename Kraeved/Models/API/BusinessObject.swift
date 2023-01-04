//
//  BusinessObject.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 23.11.2022.
//

import Foundation

struct BusinessObject: Identifiable, Codable {
    var id: UUID?
    var title: String?
    var metaTypeId: UUID?
    var customProperties: String?
    var startDate: String?
    var finishDate: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case title
        case metaTypeId
        case customProperties
        case startDate
        case finishDate
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(metaTypeId, forKey: .metaTypeId)
        try container.encode(customProperties, forKey: .customProperties)
        try container.encode(startDate, forKey: .startDate)
        try container.encode(finishDate, forKey: .finishDate)
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.metaTypeId = try container.decode(UUID.self, forKey: .metaTypeId)
        self.customProperties = try container.decode(String.self, forKey: .customProperties)
        self.startDate = try container.decode(String.self, forKey: .startDate)
        self.finishDate = try container.decode(String.self, forKey: .finishDate)
    }

    init(_ businessObject: BusinessObjectCoreModel) {
        self.id = businessObject.id
        self.title = businessObject.title
        self.metaTypeId = businessObject.metaTypeId
        self.customProperties = businessObject.customProperties
        self.startDate = businessObject.startDate
        self.finishDate = businessObject.finishDate
    }

    init(id: UUID, title: String?, metaTypeId: UUID?, customProperties: String?, startDate: String?, finishDate: String?) {
        self.id = id
        self.title = title
        self.metaTypeId = metaTypeId
        self.customProperties = customProperties
        self.startDate = startDate
        self.finishDate = finishDate
    }

    func convertToMetaObject<T: Codable>() -> MetaObject<T>? {
        guard let id = id, let json = customProperties?.data(using: .utf8)! else { return nil }
        let decoder = JSONDecoder()
        var result: MetaObject<T>
        do {
            let data = try decoder.decode(T.self, from: json)
            result = MetaObject(id: id, title: title, image: nil, data: data)
        } catch {
            debugPrint(error)
            return MetaObject(id: id)
        }
        return result
    }
}
