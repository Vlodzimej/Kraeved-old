//
//  ImageCoreModel+CoreDataClass.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 06.12.2022.
//
//

import Foundation
import CoreData


public class ImageCoreModel: NSManagedObject {
    convenience init() {
        self.init(entity: CoreDataManager.shared.entityForName(entityName: "ImageCoreModel"), insertInto: CoreDataManager.shared.managedObjectContext)
    }
}
