//
//  BusinessObjectManager.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 25.11.2022.
//

import Foundation

protocol BusinessObjectManagerProtocol: AnyObject {
    func getBusinessObjects(by metaTypeId: String, completion: @escaping ([BusinessObject]) -> Void)
}

class BusinessObjectManager: BusinessObjectManagerProtocol {

    
    static let shared = BusinessObjectManager()
    
    private let apiManager: APIManager
    
    private init(apiManager: APIManager = APIManager.shared) {
        self.apiManager = apiManager
    }
    
    func getBusinessObjects(by metaTypeId: String, completion: @escaping ([BusinessObject]) -> Void) {
        guard let url =  URL(string: "http://localhost:5211/api/BusinessObject/metaTypeId/\(metaTypeId)") else { return }
        let request = URLRequest(url: url)
        
        apiManager.get(with: request) { (response: Result<[BusinessObject], Error>) in
            switch response {
            case .success(let businessObjects):
                completion(businessObjects)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
}
