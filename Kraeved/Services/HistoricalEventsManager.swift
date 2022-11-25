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
    
    private let apiManager: APIManager
    
    private init(apiManager: APIManager = APIManager.shared) {
        self.apiManager = apiManager
    }
    
    func getHistoricalEvents(completion: @escaping ([MetaObject<HistoricalEvent>]) -> Void) {
        guard let url =  URL(string: "http://localhost:5211/api/BusinessObject") else { return }
        let request = URLRequest(url: url)
        
        apiManager.get(with: request) { (response: Result<[BusinessObject], Error>) in
            switch response {
            case .success(let businessObjects):
                if let encoded = try? JSONEncoder().encode(businessObjects) {
                    UserDefaults.standard.set(encoded, forKey: UserDefaultsKeys.historicalEvents.rawValue)
                }
                let historicalEvents: [MetaObject<HistoricalEvent>] = businessObjects.map { $0.convertToMetaObject() }
                completion(historicalEvents)
            case .failure(let error):
                debugPrint(error)
            }
            
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
