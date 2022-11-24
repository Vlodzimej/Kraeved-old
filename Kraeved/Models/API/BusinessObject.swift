//
//  BusinessObject.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 23.11.2022.
//

import Foundation

struct BusinessObject: Identifiable, Decodable {
    var id: UUID
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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.metaTypeId = try container.decode(UUID.self, forKey: .metaTypeId)
        self.customProperties = try container.decode(String.self, forKey: .customProperties)
        self.startDate = try container.decode(String.self, forKey: .startDate)
        self.finishDate = try container.decode(String.self, forKey: .finishDate)
        
    }
    
    func convertToMetaObject<T: Codable>() -> MetaObject<T> {
        guard let json = customProperties?.data(using: .utf8)! else { return MetaObject(id: id) }
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
