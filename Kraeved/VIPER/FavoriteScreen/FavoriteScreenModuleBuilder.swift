//
//  FavoriteScreenModuleBuilder.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 22.06.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

class FavoriteScreenModuleBuilder {
	// static func build(output: FavoriteScreenOutput?) -> FavoriteScreenViewController {
	static func build() -> FavoriteScreenViewController {
		let interactor = FavoriteScreenInteractor()
		let router = FavoriteScreenRouter()
		// let presenter = FavoriteScreenPresenter(interactor: interactor, output: output, router: router)
		let presenter = FavoriteScreenPresenter(interactor: interactor, router: router)
		let viewController = FavoriteScreenViewController(presenter: presenter)
		router.viewController = viewController
		presenter.view = viewController
		interactor.presenter = presenter
		return viewController
	}
}
