//
//  AnnotationManagerMock.swift
//  KraevedTests
//
//  Created by Владимир Амелькин on 09.01.2023.
//

import Foundation
@testable import Kraeved

class AnnotationManagerMock: AnnotationManagerProtocol {
    private let entityManagerMock = EntityManagerMock()
    
    func getAnnotations(completion: @escaping ([Annotation]) -> Void) {
        entityManagerMock.getAll { entities in
            let annotations: [Annotation] = entities.compactMap { Annotation($0) }
            completion(annotations)
        }
    }
    
    func addAnnotation(_ annotation: Annotation, completion: @escaping (Annotation) -> Void) {
        completion(annotation)
    }
}
