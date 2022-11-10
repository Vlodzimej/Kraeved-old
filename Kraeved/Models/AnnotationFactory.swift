//
//  AnnotationFactory.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 09.11.2022.
//

import MapKit

protocol AnnotationFactoryProtocol {
    func makeBuilding(id: Int, coordinate: CLLocationCoordinate2D, title: String, subtype: BuildingSubtype) -> Annotation
    func makeNature(id: Int, coordinate: CLLocationCoordinate2D, title: String, subtype: NaturalSubtype) -> Annotation
}


class AnnotationFactory: AnnotationFactoryProtocol {
    func makeBuilding(id: Int, coordinate: CLLocationCoordinate2D, title: String, subtype: BuildingSubtype) -> Annotation {
        return BuildingAnnotation(id: id, coordinate: coordinate, title: title, subtype: subtype)
    }
    
    func makeNature(id: Int, coordinate: CLLocationCoordinate2D, title: String, subtype: NaturalSubtype) -> Annotation {
        return NaturalAnnotaton(id: id, coordinate: coordinate, title: title, subtype: subtype)
    }
}
