//
//  AnnotationManager.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 09.11.2022.
//

import MapKit

protocol AnnotationManagerProtocol {
    func getAnnotations(completion: @escaping ([Annotation]) -> Void)
    func getTransport(completion: @escaping ([Transport]) -> Void)
}

class AnnotationManager: AnnotationManagerProtocol {

    static let shared = AnnotationManager()

    private let entityManager: EntityManagerProtocol

    private init(entityManager: EntityManagerProtocol = EntityManager.shared) {
        self.entityManager = entityManager
    }

    func getAnnotations(completion: @escaping ([Annotation]) -> Void) {
        entityManager.find(customProperties: ["typeId": EntityType.location.rawValue]) { locations in
            let annotations: [Annotation] = locations.compactMap { location in
                guard let latitude = location.data?.latitude, let longitude = location.data?.longitude else { return nil }
                let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                return Annotation(id: location.id, coordinate: coordinate, title: location.title, subtitle: "", type: .building)
            }
            completion(annotations)
        }
    }

    func getTransport(completion: @escaping ([Transport]) -> Void) {
        let result: [Transport] = [
            .init(name: "Маршрут 1", route: [1, 2]),
            .init(name: "Маршрут 2", route: [3, 1, 2]),
            .init(name: "Маршрут 3", route: [2, 3])
        ]
        completion(result)
    }
}

extension String
{
    /// EZSE: Converts String to Double
    public func toDouble() -> Double?
    {
       if let num = NumberFormatter().number(from: self) {
                return num.doubleValue
            } else {
                return nil
            }
     }
}
