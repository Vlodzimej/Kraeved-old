//
//  HistoricalEventsManager.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 21.11.2022.
//

import Foundation
import CoreData

// MARK: - EntityManagerProtocol
protocol EntityManagerProtocol: AnyObject {
    func fetchAll(completion: @escaping ([MetaObject<Entity>]) -> Void)
    func fetch(id: UUID, completion: @escaping (MetaObject<Entity>) -> Void)
    func find(customProperties: [String: String], completion: @escaping ([MetaObject<Entity>]) -> Void)
    func find(title: String, completion: @escaping ([MetaObject<Entity>]) -> Void)
    func add(entity: MetaObject<Entity>, completion: @escaping (MetaObject<Entity>) -> Void)
}

let entitesData: [MetaObject<Entity>] = [
    .init(id: UUID(), title: "Здесь должен быть текст.", image: nil, data: Entity(imageUrl: "https://cdn2.tu-tu.ru/image/pagetree_node_data/1/0c31af95d0e82b795d38537b3f71235e/", text: "Тестовый текст", typeId: UUID.init(uuidString: EntityType.historicalEvent.rawValue))),
    .init(id: UUID(), title: "Второе тестовое событие", image: nil, data: Entity(imageUrl: "https://ugs.gazprom.ru/d/story/04/260/kaluga-03_novyj_razmer.jpg", text: "Тестовый текст", typeId: UUID.init(uuidString: EntityType.historicalEvent.rawValue))),
    .init(id: UUID(), title: "Третье тестовое событие", image: nil, data: Entity(imageUrl: "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0b/d1/f8/87/caption.jpg?w=700&h=500&s=1", text: "Тестовый текст", typeId: UUID.init(uuidString: EntityType.historicalEvent.rawValue))),
    .init(id: UUID(), title: "Здесь должен быть текст.", image: nil, data: Entity(imageUrl: "https://cdn2.tu-tu.ru/image/pagetree_node_data/1/0c31af95d0e82b795d38537b3f71235e/", text: "Тестовый текст", typeId: UUID.init(uuidString: EntityType.historicalEvent.rawValue))),
    .init(id: UUID(), title: "Второе тестовое событие", image: nil, data: Entity(imageUrl: "https://ugs.gazprom.ru/d/story/04/260/kaluga-03_novyj_razmer.jpg", text: "Тестовый текст", typeId: UUID.init(uuidString: EntityType.historicalEvent.rawValue))),
    .init(id: UUID(), title: "Третье тестовое событие", image: nil, data: Entity(imageUrl: "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0b/d1/f8/87/caption.jpg?w=700&h=500&s=1", text: "Тестовый текст", typeId: UUID.init(uuidString: EntityType.historicalEvent.rawValue))),

]

// MARK: - EntityManager
final class EntityManager: EntityManagerProtocol {

    static let shared = EntityManager()

    private let businessObjectManager: BusinessObjectManagerProtocol
    private let imageManager: ImageManagerProtocol

    init(businessObjectManager: BusinessObjectManagerProtocol = BusinessObjectManager.shared, imageManager: ImageManagerProtocol = ImageManager.shared) {
        self.businessObjectManager = businessObjectManager
        self.imageManager = imageManager
    }

    func fetchAll(completion: @escaping ([MetaObject<Entity>]) -> Void) {
        completion(entitesData)
//        businessObjectManager.get(metaTypeId: MetaType.entity.id) { (businessObjects: [BusinessObject]) in
//            let entities: [MetaObject<Entity>] = businessObjects.compactMap { $0.convertToMetaObject() }
//            completion(entities)
//        }
    }
    
    func fetch(id: UUID, completion: @escaping (MetaObject<Entity>) -> Void) {
        businessObjectManager.find(metaTypeId: MetaType.entity.id, predicates: [NSPredicate(format: "%K = %@", "id", id.uuidString)]) { [weak self] businessObjects in
            guard let self = self, let businessObject = businessObjects.first,
                  let entity: MetaObject<Entity> = businessObject.convertToMetaObject() else { return }
            if let imageUrl = entity.data?.imageUrl, let url = URL(string: imageUrl) {
                self.imageManager.downloadImage(from: url) { image in
                    let resultEntity = MetaObject<Entity>(id: entity.id, title: entity.title, image: image, data: entity.data)
                    completion(resultEntity)
                }
            } else {
                completion(entity)
            }
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
    
    func add(entity: MetaObject<Entity>, completion: @escaping (MetaObject<Entity>) -> Void) {
        guard let businessObject = entity.convertToBusinessObject() else { return }
        businessObjectManager.add(businessObject) { result in
            guard let entity: MetaObject<Entity> = result.convertToMetaObject() else { return }
            completion(entity)
        }
    }
}
