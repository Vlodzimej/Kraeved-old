//
//  BaseRouterMock.swift
//  KraevedTests
//
//  Created by Владимир Амелькин on 21.12.2022.
//

import Foundation
@testable import Kraeved

class BaseRouterMock: MainScreenRouterProtocol {

    var isOpenedAnnotation: Bool = false
    var isOpenedEntityDetails: Bool = false

    func openAnnotation(annotation: Kraeved.Annotation) {
        isOpenedAnnotation = true
    }

    func openEntityDetails(id: UUID) {
        isOpenedEntityDetails = true
    }
}
