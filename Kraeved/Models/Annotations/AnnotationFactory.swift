//
//  AnnotationFactory.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 09.11.2022.
//

import MapKit

// Пример паттерна Фабрика

enum BuildingSubtype {
    case house
    case administrative
    case culture
    case market
    case moll
}

enum NaturalSubtype {
    case pond
    case forest
    case rill
    case reserve
}

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

class BuildingAnnotation: Annotation {

    let subtype: BuildingSubtype

    init(id: Int, coordinate: CLLocationCoordinate2D, title: String, subtype: BuildingSubtype) {
        self.subtype = subtype
        super.init(id: id, coordinate: coordinate, title: title, subtitle: nil, type: .building)
    }
}

class NaturalAnnotaton: Annotation {

    let subtype: NaturalSubtype

    init(id: Int, coordinate: CLLocationCoordinate2D, title: String, subtype: NaturalSubtype) {
        self.subtype = subtype
        super.init(id: id, coordinate: coordinate, title: title, subtitle: nil, type: .natural)
    }
}
