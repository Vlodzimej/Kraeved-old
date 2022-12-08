//
//  Entity.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 21.11.2022.
//
import Foundation

enum EntityType: String, CaseIterable {
    case historicalEvent = "a58aa211-d7a0-461a-8d0a-7f90db0bd06b"
    case location = "fd16f472-2230-4fd0-a532-44854f12d749"
    case photo = "9e411fa3-5761-43f7-acef-f4bb47692406"
}

struct Entity: Codable {
    var imageUrl: String?
    var text: String?
    var typeId: UUID?
    var subtypeId: UUID?
    var longitude: Double?
    var latitude: Double?
}




