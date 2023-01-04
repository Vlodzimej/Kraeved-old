//
//  StartScreenPresenter.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 04.01.2023.
//

import UIKit

// MARK: - StartScreenPresenterProtocol
protocol StartScreenPresenterProtocol: AnyObject, PhoneFormViewDelegate {
    func dismiss()
}

// MARK: - StartScreenPresenter
class StartScreenPresenter: StartScreenPresenterProtocol {

    // MARK: Properties
    weak var view: StartScreenViewProtocol?
    private let interactor: StartScreenInteractorProtocol
    private let router: StartScreenRouterProtocol

    // MARK: Init
    init(interactor: StartScreenInteractorProtocol, router: StartScreenRouterProtocol) {
        self.router = router
        self.interactor = interactor
    }
    
    func dismiss() {
        router.dismiss()
    }
}

extension StartScreenPresenter: PhoneFormViewDelegate {
    func sendPhone(_ phone: String) {
        print(phone)
        view?.showCodeForm()
    }
}
