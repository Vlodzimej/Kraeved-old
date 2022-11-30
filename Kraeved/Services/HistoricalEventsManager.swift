//
//  HistoricalEventsManager.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 21.11.2022.
//

import Foundation
import CoreData

protocol HistoricalEventsManagerProtocol: AnyObject {
    func get(completion: @escaping ([MetaObject<HistoricalEvent>]) -> Void)
    func find(arguments: [String : String], completion: @escaping ([MetaObject<HistoricalEvent>]) -> Void)
    func find(title: String, completion: @escaping ([MetaObject<HistoricalEvent>]) -> Void)
}

class HistoricalEventsManager: HistoricalEventsManagerProtocol {
    
    static let shared = HistoricalEventsManager()
    
    private let businessObjectManager: BusinessObjectManagerProtocol
    
    private init(businessObjectManager: BusinessObjectManagerProtocol = BusinessObjectManager.shared) {
        self.businessObjectManager = businessObjectManager
    }
    
    func get(completion: @escaping ([MetaObject<HistoricalEvent>]) -> Void) {
        businessObjectManager.get(metaTypeId: MetaType.historicalEvent.rawValue) {
            (businessObjects: [BusinessObject]) in
            let historicalEvents: [MetaObject<HistoricalEvent>] = businessObjects.compactMap { $0.convertToMetaObject() }
            completion(historicalEvents)
        }
    }
    
    func find(arguments: [String : String], completion: @escaping ([MetaObject<HistoricalEvent>]) -> Void) {
        let predicates = arguments.map { NSPredicate(format: "%K = %@", $0.key, $0.value) }
        businessObjectManager.find(metaTypeId: MetaType.historicalEvent.rawValue, predicates: predicates) { businessObjects in
            let historicalEvents: [MetaObject<HistoricalEvent>] = businessObjects.compactMap { $0.convertToMetaObject() }
            completion(historicalEvents)
        }
    }
    
    func find(title: String, completion: @escaping ([MetaObject<HistoricalEvent>]) -> Void) {
        let predicate = NSPredicate(format: "%K CONTAINS[cd] %@", "title", title)
        businessObjectManager.find(metaTypeId: MetaType.historicalEvent.rawValue, predicates: [predicate]) { businessObjects in
            let historicalEvents: [MetaObject<HistoricalEvent>] = businessObjects.compactMap { $0.convertToMetaObject() }
            completion(historicalEvents)
        }
    }
}
