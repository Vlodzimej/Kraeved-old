//
//  AnnotationManager.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 09.11.2022.
//

import MapKit

protocol AnnotationManagerProtocol {
    func getAnnotations(completion: @escaping ([Annotation]) -> Void)
    func addAnnotation(_ annotation: Annotation, completion: @escaping (Annotation) -> Void)
}

class AnnotationManager: AnnotationManagerProtocol {

    static let shared = AnnotationManager()

    private let entityManager: EntityManagerProtocol

    private init(entityManager: EntityManagerProtocol = EntityManager.shared) {
        self.entityManager = entityManager
    }

    func getAnnotations(completion: @escaping ([Annotation]) -> Void) {
        entityManager.find(customProperties: ["typeId": EntityType.location.rawValue]) { locations in
            let annotations: [Annotation] = locations.compactMap { Annotation($0) }
            completion(annotations)
        }
    }
    
    func addAnnotation(_ annotation: Annotation, completion: @escaping (Annotation) -> Void) {
        guard let entity = annotation.convertToEntity() else { return }
        entityManager.add(entity: entity) { result in
            completion(Annotation(result))
        }
    }
}

extension String {
    public func toDouble() -> Double? {
        if let num = NumberFormatter().number(from: self) {
                return num.doubleValue
            } else {
                return nil
            }
    }
}
