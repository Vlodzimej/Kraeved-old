//
//  HistoricalEventsManager.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 21.11.2022.
//

import Foundation

protocol HistoricalEventsManagerProtocol: AnyObject {
    func getHistoricalEvents(completion: @escaping ([MetaObject<HistoricalEvent>]) -> Void)
    func getHistoricalEvent(by id: UUID, completion: @escaping (MetaObject<HistoricalEvent>) -> Void)
}

class HistoricalEventsManager: HistoricalEventsManagerProtocol {
    
    static let shared = HistoricalEventsManager()
    
    private let businessObjectManager: BusinessObjectManagerProtocol
    
    private init(businessObjectManager: BusinessObjectManagerProtocol = BusinessObjectManager.shared) {
        self.businessObjectManager = businessObjectManager
    }
    
    func getHistoricalEvents(completion: @escaping ([MetaObject<HistoricalEvent>]) -> Void) {
        businessObjectManager.getBusinessObjects(by: MetaType.historicalEvent.rawValue) {
            (businessObjects: [BusinessObject]) in
            if let encoded = try? JSONEncoder().encode(businessObjects) {
                UserDefaults.standard.set(encoded, forKey: UserDefaultsKeys.historicalEvents.rawValue)
            }
            let historicalEvents: [MetaObject<HistoricalEvent>] = businessObjects.map { $0.convertToMetaObject() }
            completion(historicalEvents)
        }
    }
    
    func getHistoricalEvent(by id: UUID, completion: @escaping (MetaObject<HistoricalEvent>) -> Void) {
        if let data = UserDefaults.standard.object(forKey: UserDefaultsKeys.historicalEvents.rawValue) as? Data,
           let businessObjects = try? JSONDecoder().decode([BusinessObject].self, from: data) {
            guard let businessObject = businessObjects.first(where: { $0.id == id }) else { return }
            let historicalEvent: MetaObject<HistoricalEvent> = businessObject.convertToMetaObject()
            completion(historicalEvent)
        }
    }
}
