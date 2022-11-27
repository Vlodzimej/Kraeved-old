//
//  HistoricalEventModuleBuilder.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 23.11.2022.
//

import Foundation

class HistoricalEventModuleBuilder {
    static func build(id: UUID) -> HistoricalEventViewController {
		let interactor = HistoricalEventInteractor()
		let router = HistoricalEventRouter()
		let presenter = HistoricalEventPresenter(interactor: interactor, router: router, id: id)
		let viewController = HistoricalEventViewController(presenter: presenter)
		router.viewController = viewController
		presenter.view = viewController
		interactor.presenter = presenter
		return viewController
	}
}
