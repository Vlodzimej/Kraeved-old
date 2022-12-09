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
    func find(title: String, completion: @escaping ([MetaObject<Entity>]) -> Void)
}

class EntityManager: EntityManagerProtocol {

    static let shared = EntityManager()

    private let businessObjectManager: BusinessObjectManagerProtocol

    private init(businessObjectManager: BusinessObjectManagerProtocol = BusinessObjectManager.shared) {
        self.businessObjectManager = businessObjectManager
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

    func find(title: String, completion: @escaping ([MetaObject<Entity>]) -> Void) {
        let predicate = NSPredicate(format: "%K CONTAINS[cd] %@", "title", title)
        businessObjectManager.find(metaTypeId: MetaType.entity.id, predicates: [predicate]) { businessObjects in
            let entities: [MetaObject<Entity>] = businessObjects.compactMap { $0.convertToMetaObject() }
            completion(entities)
        }
    }
}
