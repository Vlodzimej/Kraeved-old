//
//  StartScreenInteractor.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 04.01.2023.
//

import Foundation

// MARK: - StartScreenInteractorProtocol
protocol StartScreenInteractorProtocol: AnyObject {
}

// MARK: - StartScreenInteractor
class StartScreenInteractor: StartScreenInteractorProtocol {

    // MARK: Properties
    weak var presenter: StartScreenPresenterProtocol?

    // MARK: Init
    init() {
    }

    // MARK: Private Methods

    // MARK: Public Methods
}
