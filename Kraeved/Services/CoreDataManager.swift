//
//  CoreDataManager.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 28.11.2022.
//

import UIKit
import Foundation
import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    //MARK: - Properties
    lazy var applicationDocumentsDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        guard let modelURL = Bundle.main.url(forResource: "Kraeved", withExtension: "momd"),
              let model = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError()
        }
        return model
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathExtension("Kraeved.momd")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options:
                                                [NSMigratePersistentStoresAutomaticallyOption: true,
                                                       NSInferMappingModelAutomaticallyOption: true] as [NSObject : AnyObject])
        } catch {
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.automaticallyMergesChangesFromParent = true
        managedObjectContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    private init() {}
    
    //MARK: - Public Methods
    func entityForName(entityName: String) -> NSEntityDescription {
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: self.managedObjectContext)!
        let test = entity.uniquenessConstraints
        return entity
    }
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
                try managedObjectContext.save()
            } catch {
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    func isExist(entityName: String, id: UUID) -> Bool {
        var result = true
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "id = %d", argumentArray: [id.uuidString])
        let fetchResult = try? managedObjectContext.fetch(fetchRequest)
        if let count = fetchResult?.count {
            result = count > 0 ? true : false
        }
        return result
    }
    
    func removeAllEntities(entityName: String) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try managedObjectContext.execute(deleteRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
}
