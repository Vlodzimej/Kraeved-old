//
//  BusinessObjectCoreModel+CoreDataProperties.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 28.11.2022.
//
//

import Foundation
import CoreData

extension BusinessObjectCoreModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BusinessObjectCoreModel> {
        return NSFetchRequest<BusinessObjectCoreModel>(entityName: "BusinessObjectCoreModel")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var metaTypeId: UUID?
    @NSManaged public var customProperties: String?
    @NSManaged public var finishDate: String?
    @NSManaged public var startDate: String?

    @discardableResult
    convenience init(_ businessObject: BusinessObject) {
        self.init()
        self.id = businessObject.id
        self.title = businessObject.title
        self.metaTypeId = businessObject.metaTypeId
        self.customProperties = businessObject.customProperties
        self.startDate = businessObject.startDate
        self.finishDate = businessObject.finishDate
    }

}
