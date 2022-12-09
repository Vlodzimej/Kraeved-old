//
//  EntityDetailsPresenter.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 23.11.2022.
//

import UIKit

//MARK: - EntityDetailsPresenterProtocol
protocol EntityDetailsPresenterProtocol: AnyObject {
    func viewDidLoad()
}

//MARK: - EntityDetailsPresenter
class EntityDetailsPresenter: EntityDetailsPresenterProtocol {

    //MARK: Properties
    weak var view: EntityDetailsViewProtocol?
    private let interactor: EntityDetailsInteractorProtocol
    private let router: EntityDetailsRouterProtocol
    
    private let id: UUID

    //MARK: Init
    init(interactor: EntityDetailsInteractorProtocol, router: EntityDetailsRouterProtocol, id: UUID) {
        self.router = router
        self.interactor = interactor
        self.id = id
    }
    
    func viewDidLoad() {
        interactor.getEntity(id: id) { [weak self] entity in
            guard let self = self, let type = EntityType.allCases.first(where: { $0.rawValue.uppercased() == entity.data?.typeId?.uuidString }) else { return }
            DispatchQueue.main.async {
                self.view?.update(entity: entity)
            }
        }
    }
}
