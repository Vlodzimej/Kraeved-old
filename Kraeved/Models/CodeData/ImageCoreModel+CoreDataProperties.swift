//
//  ImageCoreModel+CoreDataProperties.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 06.12.2022.
//
//

import Foundation
import CoreData

extension ImageCoreModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageCoreModel> {
        return NSFetchRequest<ImageCoreModel>(entityName: "ImageCoreModel")
    }

    @NSManaged public var data: Data?
    @NSManaged public var imageUrl: String?

    @discardableResult
    convenience init(data: Data, imageUrl: String) {
        self.init()
        self.data = data
        self.imageUrl = imageUrl
    }
}
