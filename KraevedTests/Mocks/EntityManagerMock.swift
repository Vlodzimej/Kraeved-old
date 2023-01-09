//
//  EntityManagerMock.swift
//  KraevedTests
//
//  Created by Владимир Амелькин on 09.01.2023.
//

import Foundation
@testable import Kraeved

final class EntityManagerMock: EntityManagerProtocol {
    
    private func makeEntites() -> [MetaObject<Entity>] {
        let uuids: [UUID] = [
            UUID(uuidString: "6495f97b-bbcd-4cd3-9d11-44e4b05ccdd4") ?? UUID(),
            UUID(uuidString: "63e13da7-b247-4702-a9b0-978d52b13db1") ?? UUID(),
            UUID(uuidString: "93823e3a-b6f1-41ef-bfb6-c0aac3df253d") ?? UUID()
        ]
        
        let data: [Entity] = [
            .init(imageUrl: nil, text: "Описание 1", typeId: EntityType.annotation.id, longitude: nil, latitude: nil),
            .init(imageUrl: nil, text: "Описание 2", typeId: EntityType.annotation.id, longitude: nil, latitude: nil),
            .init(imageUrl: nil, text: "Описание 3", typeId: EntityType.annotation.id, longitude: nil, latitude: nil)
        ]
        
        return (0...2).map { .init(id: uuids[$0], title: "Тест 1", image: nil, data: data[$0]) }
    }
    
    func getAll(completion: @escaping ([MetaObject<Entity>]) -> Void) {
        let entities = makeEntites()
        completion(entities)
    }
    
    func get(id: UUID, completion: @escaping (MetaObject<Entity>) -> Void) {
        let entities = makeEntites()
        guard let entity = entities.first(where: { $0.id == id }) else { return }
        completion(entity)
    }
    
    func find(customProperties: [String: String], completion: @escaping ([MetaObject<Entity>]) -> Void) {
        let entities = makeEntites()
        completion(entities)
    }
    
    func find(title: String, completion: @escaping ([MetaObject<Entity>]) -> Void) {
        let entities = makeEntites()
        completion(entities)
    }
    
    func add(entity: MetaObject<Entity>, completion: @escaping (MetaObject<Entity>) -> Void) {
        completion(entity)
    }
}
