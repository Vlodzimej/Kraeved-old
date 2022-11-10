//
//  Transport.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 10.11.2022.
//

import Foundation

struct Transport {
    let name: String
    let route: [Int]
    
    func isVisit(annotationId: Int) -> Bool {
        route.contains(annotationId)
    }
}
