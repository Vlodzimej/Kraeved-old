//
//  Entity.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 21.11.2022.
//
import Foundation

enum EntityType: String, CaseIterable {
    case historicalEvent = "A58AA211-D7A0-461A-8D0A-7F90DB0BD06B"
    case location = "FD16F472-2230-4FD0-A532-44854F12D749"
    case photo = "9E411FA3-5761-43F7-ACEF-F4BB47692406"
}

struct Entity: Codable {
    var imageUrl: String?
    var text: String?
    var typeId: UUID?
    var subtypeId: UUID?
    var longitude: Double?
    var latitude: Double?
}
