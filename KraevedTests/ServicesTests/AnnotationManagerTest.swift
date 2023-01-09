//
//  AnnotationManagerTest.swift
//  KraevedTests
//
//  Created by Владимир Амелькин on 09.01.2023.
//

import XCTest
import MapKit
@testable import Kraeved

final class AnnotationManagerTest: XCTestCase {
    
    var annotationManager: AnnotationManagerProtocol!
    
    override func setUpWithError() throws {
        let entityManagerMock = EntityManagerMock()

        annotationManager = AnnotationManager(entityManager: entityManagerMock)
    }
    
    override func tearDownWithError() throws {
        annotationManager = nil
    }
    
    func testGetAnnotations() {
        annotationManager.getAnnotations { annotations in
            XCTAssertEqual(annotations.count, 3)
        }
    }
    
    func testAddAnnotation() {
        guard let id = UUID(uuidString: "566e99f6-999f-46f4-a8c6-1e0878281cde") else { return }
        let coordinate = CLLocationCoordinate2D(latitude: 0.0000, longitude: 0.000)
        let annotation = Annotation(id: id, coordinate: coordinate, title: "Тест", subtitle: nil)
        annotationManager.addAnnotation(annotation) { result in
            XCTAssertEqual(result.id, id)
        }
    }
}
