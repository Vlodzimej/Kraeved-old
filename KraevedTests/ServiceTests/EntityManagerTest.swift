//
//  EntityManagerTest.swift
//  KraevedTests
//
//  Created by Владимир Амелькин on 21.12.2022.
//

import XCTest
@testable import Kraeved

final class EntityManagerTest: XCTestCase {

    var entityManager: EntityManagerProtocol!

    override func setUpWithError() throws {
        let businessObjectManager = BusinessObjectManagerMock()
        let imageManager = ImageManagerMock()

        entityManager = EntityManager(businessObjectManager: businessObjectManager, imageManager: imageManager)
    }

    override func tearDownWithError() throws {
        entityManager = nil
    }

    func testGetEntities() throws {
        entityManager.get { entities in
            XCTAssertEqual(entities.count, 3, "entities count must be 3")
        }
    }

    func testGetEntity() throws {
        guard let uuid = UUID(uuidString: "21af1cad-7a20-427a-a9c7-c4bafcfffc79") else { return }
        entityManager.getEntity(id: uuid) { entity in
            XCTAssertEqual(entity.title, "Тестовый БО-1", "entity title must containts string: 'Тестовый БО-1'")
        }
    }

    func testCustomProperties() throws {
        guard let uuid = UUID(uuidString: "21af1cad-7a20-427a-a9c7-c4bafcfffc79") else { return }
        entityManager.getEntity(id: uuid) { entity in
            XCTAssertEqual(entity.data?.text, "Тестовый текст", "entity data text field must containts string: 'Тестовый текст'")
        }
    }
}
