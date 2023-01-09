//
//  MessageScreenPresenter.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 05.01.2023.
//

import UIKit

// MARK: - MessageScreenPresenterProtocol
protocol MessageScreenPresenterProtocol: AnyObject {
    func dismiss()
}

// MARK: - MessageScreenPresenter
final class MessageScreenPresenter: MessageScreenPresenterProtocol {

    // MARK: Properties
    weak var view: MessageScreenViewProtocol?
    private let router: BaseRouterProtocol

    // MARK: Init
    init(router: BaseRouterProtocol) {
        self.router = router
    }
    
    func dismiss() {
        router.dismiss()
    }
}
