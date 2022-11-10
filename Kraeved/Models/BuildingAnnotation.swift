//
//  BuildingAnnotation.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 09.11.2022.
//

import MapKit

enum BuildingSubtype {
    case house
    case administrative
    case culture
    case market
    case moll
}

class BuildingAnnotation: Annotation {

    let subtype: BuildingSubtype
    
    init(id: Int, coordinate: CLLocationCoordinate2D, title: String, subtype: BuildingSubtype) {
        self.subtype = subtype
        super.init(id: id, coordinate: coordinate, title: title, subtitle: nil, type: .building)
    }
}
