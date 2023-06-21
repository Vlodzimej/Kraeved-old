//
//  EntityDetailsPresenter.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 23.11.2022.
//

import UIKit

// MARK: - EntityDetailsPresenterProtocol
protocol EntityDetailsPresenterProtocol: AnyObject {
    var entity: MetaObject<Entity> { get }
}

// MARK: - EntityDetailsPresenter
final class EntityDetailsPresenter: EntityDetailsPresenterProtocol {

    // MARK: Properties
    weak var view: EntityDetailsViewProtocol?
    private let interactor: EntityDetailsInteractorProtocol
    private let router: EntityDetailsRouterProtocol

    private(set) var entity: MetaObject<Entity>

    // MARK: Init
    init(interactor: EntityDetailsInteractorProtocol, router: EntityDetailsRouterProtocol, entity: MetaObject<Entity>) {
        self.router = router
        self.interactor = interactor
        self.entity = entity
    }
}
