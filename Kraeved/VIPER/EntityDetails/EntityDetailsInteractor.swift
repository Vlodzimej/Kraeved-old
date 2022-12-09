//
//  EntityDetailsInteractorProtocol.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 23.11.2022.
//

import Foundation

//MARK: - EntityDetailsInteractorProtocol
protocol EntityDetailsInteractorProtocol: AnyObject {
    func getEntity(id: UUID, completion: @escaping (MetaObject<Entity>) -> ())
}

//MARK: - EntityDetailsInteractor
class EntityDetailsInteractor: EntityDetailsInteractorProtocol {

    //MARK: Properties
    weak var presenter: EntityDetailsPresenterProtocol?
    
    private let businessObjectManager: BusinessObjectManagerProtocol

    //MARK: Init
    init(businessObjectManager: BusinessObjectManagerProtocol = BusinessObjectManager.shared) {
        self.businessObjectManager = businessObjectManager
    }

    //MARK: Private Methods

    //MARK: Public Methods
    func getEntity(id: UUID, completion: @escaping (MetaObject<Entity>) -> ()) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            self.businessObjectManager.find(metaTypeId: MetaType.entity.id, predicates: [NSPredicate(format: "%K = %@", "id", id.uuidString)]) { businessObjects in
                guard let businessObject = businessObjects.first,
                      let entity: MetaObject<Entity> = businessObject.convertToMetaObject() else { return }
                completion(entity)
            }
        }
    }
}
