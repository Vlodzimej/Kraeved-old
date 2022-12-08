//
//  BusinessObjectManager.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 25.11.2022.
//

import Foundation
import CoreData

//MARK: - BusinessObjectManagerProtocol
protocol BusinessObjectManagerProtocol: AnyObject {
    func get(metaTypeId: UUID, completion: @escaping ([BusinessObject]) -> Void)
    func find(metaTypeId: UUID, predicates: [NSPredicate], completion: @escaping ([BusinessObject]) -> Void)
}

//MARK: - BusinessObjectManager
class BusinessObjectManager: BusinessObjectManagerProtocol {
    
    
    static let shared = BusinessObjectManager()
    
    private let apiManager: APIManager
    private let coreDataManager: CoreDataManagerProtocol
    
    private init(apiManager: APIManager = APIManager.shared, coreDataManager: CoreDataManagerProtocol = CoreDataManager.shared) {
        self.apiManager = apiManager
        self.coreDataManager = coreDataManager
    }
    
    /**
     Получение и кэширование бизнес-объектов
    */
    func get(metaTypeId: UUID, completion: @escaping ([BusinessObject]) -> Void) {
        guard let url =  URL(string: "http://178.250.159.110/api/BusinessObject/metaTypeId/\(metaTypeId.uuidString)") else { return }
        let request = URLRequest(url: url)
        apiManager.get(with: request) { (response: Result<[BusinessObject], Error>) in
            switch response {
            case .success(let businessObjects):
                businessObjects.forEach { BusinessObjectCoreModel($0) }
                self.coreDataManager.saveContext()
                completion(businessObjects)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    /**
     Поиск по кэшированным бизнес-объектам
     */
    func find(metaTypeId: UUID, predicates: [NSPredicate], completion: @escaping ([BusinessObject]) -> Void) {
        let concurrentQueeue = DispatchQueue(label: "kraeved-serial")
        concurrentQueeue.async { [weak self] in
            guard let self = self else { return }
            var subPredicates = [NSPredicate(format: "%K = %@", "metaTypeId", metaTypeId.uuidString)]
            subPredicates += predicates
            let result = self.coreDataManager.find(entityName: "BusinessObjectCoreModel", predicates: subPredicates)
            let businessObjects: [BusinessObject] = result.compactMap { item in
                guard let item = item as? BusinessObjectCoreModel else { return nil }
                return BusinessObject(item)
            }
            completion(businessObjects)
        }
    }
}
