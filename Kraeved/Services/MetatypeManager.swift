//
//  MetatypeManager.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 03.07.2023.
//

import Foundation

protocol MetatypeManagerProtocol: AnyObject { }

final class MetatypeManager: MetatypeManagerProtocol {
    
    // MARK: Properties
    private let apiManager: APIManager
    private let coreDataManager: CoreDataManagerProtocol
    
    // MARK: Init
    private init(apiManager: APIManager = APIManager.shared, coreDataManager: CoreDataManagerProtocol = CoreDataManager.shared) {
        self.apiManager = apiManager
        self.coreDataManager = coreDataManager
    }
}
