//
//  HistoricalEventsManager.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 21.11.2022.
//

import Foundation
import CoreData

protocol EntityManagerProtocol: AnyObject {
    func get(completion: @escaping ([MetaObject<Entity>]) -> Void)
    func find(arguments: [String: String], completion: @escaping ([MetaObject<Entity>]) -> Void)
    func find(customProperties: [String: String], completion: @escaping ([MetaObject<Entity>]) -> Void)
    func find(title: String, completion: @escaping ([MetaObject<Entity>]) -> Void)
    func getEntity(id: UUID, completion: @escaping (MetaObject<Entity>) -> Void)
}

final class EntityManager: EntityManagerProtocol {

    static let shared = EntityManager()

    private let businessObjectManager: BusinessObjectManagerProtocol
    private let imageManager: ImageManagerProtocol

    private init(businessObjectManager: BusinessObjectManagerProtocol = BusinessObjectManager.shared, imageManager: ImageManagerProtocol = ImageManager.shared) {
        self.businessObjectManager = businessObjectManager
        self.imageManager = imageManager
    }

    func get(completion: @escaping ([MetaObject<Entity>]) -> Void) {
        businessObjectManager.get(metaTypeId: MetaType.entity.id) { (businessObjects: [BusinessObject]) in
            let entities: [MetaObject<Entity>] = businessObjects.compactMap { $0.convertToMetaObject() }
            completion(entities)
        }
    }

    func find(arguments: [String: String], completion: @escaping ([MetaObject<Entity>]) -> Void) {
        let predicates = arguments.map { NSPredicate(format: "%K = %@", $0.key, $0.value) }
        businessObjectManager.find(metaTypeId: MetaType.entity.id, predicates: predicates) { businessObjects in
            let entities: [MetaObject<Entity>] = businessObjects.compactMap { $0.convertToMetaObject() }
            completion(entities)
        }
    }

    func find(customProperties: [String: String], completion: @escaping ([MetaObject<Entity>]) -> Void) {
        let predicates = customProperties.map { NSPredicate(format: "%K CONTAINS[cd] %@", "customProperties", $0.value) }
        businessObjectManager.find(metaTypeId: MetaType.entity.id, predicates: predicates) { businessObjects in
            let entities: [MetaObject<Entity>] = businessObjects.compactMap { $0.convertToMetaObject() }
            completion(entities)
        }
    }

    func find(title: String, completion: @escaping ([MetaObject<Entity>]) -> Void) {
        let predicate = NSPredicate(format: "%K CONTAINS[cd] %@", "title", title)
        businessObjectManager.find(metaTypeId: MetaType.entity.id, predicates: [predicate]) { businessObjects in
            let entities: [MetaObject<Entity>] = businessObjects.compactMap { $0.convertToMetaObject() }
            completion(entities)
        }
    }

    func getEntity(id: UUID, completion: @escaping (MetaObject<Entity>) -> Void) {
        businessObjectManager.find(metaTypeId: MetaType.entity.id, predicates: [NSPredicate(format: "%K = %@", "id", id.uuidString)]) { [weak self] businessObjects in
            guard let self = self, let businessObject = businessObjects.first,
                  let entity: MetaObject<Entity> = businessObject.convertToMetaObject() else { return }
            if let imageUrl = entity.data?.imageUrl, let url = URL(string: imageUrl) {
                self.imageManager.downloadImage(from: url) { image in
                    let resultEntity = MetaObject<Entity>(id: entity.id, title: entity.title, image: image, data: entity.data)
                    completion(resultEntity)
                }
            }
            completion(entity)
        }
    }
}
