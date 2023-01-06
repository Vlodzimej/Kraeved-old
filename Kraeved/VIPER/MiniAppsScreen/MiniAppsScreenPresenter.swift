//
//  MiniAppsScreenPresenter.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 24.12.2022.
//

import UIKit

// MARK: - MiniAppsScreenPresenterProtocol
protocol MiniAppsScreenPresenterProtocol: AnyObject, MiniaAppCollectionAdapterDelegate {
}

// MARK: - MiniAppsScreenPresenter
final class MiniAppsScreenPresenter: MiniAppsScreenPresenterProtocol {

    // MARK: Properties
    weak var view: MiniAppsScreenViewProtocol?
    private let interactor: MiniAppsScreenInteractorProtocol
    private let router: MiniAppsScreenRouterProtocol

    // MARK: Init
    init(interactor: MiniAppsScreenInteractorProtocol, router: MiniAppsScreenRouterProtocol) {
        self.router = router
        self.interactor = interactor
    }
}

extension MiniAppsScreenPresenter: MiniaAppCollectionAdapterDelegate {
    func showMessage() {
        router.showMessageScreen("Сервис находится в разработке")
    }
    
    func openGenealogy() {
        router.openGenealogy()
    }
}
