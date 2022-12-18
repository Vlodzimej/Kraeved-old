//
//  Annotation.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 29.06.2022.
//

import Foundation
import MapKit

enum AnnotationType {
    case building
    case natural
}

protocol AnnotationProtocol: AnyObject {
    func updateText(_ text: String)
    func getTextInfo() -> String?
    func getDiscription() -> String?
}

class Annotation: NSObject, MKAnnotation, AnnotationProtocol {

    var id: UUID

    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?

    let startDate: Date?
    let type: AnnotationType

    private var text: String?

    init(id: UUID, coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?, type: AnnotationType, startDate: Date? = nil) {
        self.id = id
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.type = type
        self.startDate = startDate
    }

    func updateText(_ text: String) {
        self.text = text
    }

    func getTextInfo() -> String? {
        if let title = title {
            return "\(title)/n\(subtitle ?? "")"
        } else if let subtitle = subtitle {
            return subtitle
        } else {
            return nil
        }
    }

    func getDiscription() -> String? {
        return text
    }
}

class AnnotationDecorator: AnnotationProtocol {
    let decoratedAnnotation: AnnotationProtocol

    required init(_ decoratedAnnotation: Annotation) {
        self.decoratedAnnotation = decoratedAnnotation
    }

    func updateText(_ text: String) {
        decoratedAnnotation.updateText(text)
    }

    func getTextInfo() -> String? {
        return decoratedAnnotation.getTextInfo()
    }

    func getDiscription() -> String? {
        return decoratedAnnotation.getDiscription()
    }
}

class Mark: AnnotationDecorator {
    required init(_ decoratedAnnotation: Annotation) {
        super.init(decoratedAnnotation)
    }

    override func getTextInfo() -> String? {
        guard let text = decoratedAnnotation.getDiscription() else { return nil }
        return "MARK:\n\(text)"
    }

}

// struct AnnotationDto: Decodable {
//    let id: Int?
//    let title: String?
//    let latitude: String?
//    let longitude: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id, title, latitude, longitude
//    }
// }
