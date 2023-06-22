//
//  FavoriteScreenPresenter.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 22.06.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

//MARK: - FavoriteScreenPresenterProtocol
protocol FavoriteScreenPresenterProtocol: AnyObject {
}

//MARK: - FavoriteScreenOutput
// protocol FavoriteScreenModuleOutput: AnyObject {
// }

//MARK: - FavoriteScreenPresenter
class FavoriteScreenPresenter: FavoriteScreenPresenterProtocol {

    //MARK: Properties
    weak var view: FavoriteScreenViewProtocol?
    // private weak var output: FavoriteScreenModuleOutput?
    private let interactor: FavoriteScreenInteractorProtocol
    private let router: FavoriteScreenRouterProtocol

    //MARK: Init
    // init(interactor: FavoriteScreenInteractorProtocol, output: FavoriteScreenModuleOutput?, router: FavoriteScreenRouterProtocol) {
    //     self.output = output
    init(interactor: FavoriteScreenInteractorProtocol, router: FavoriteScreenRouterProtocol) {
        self.router = router
        self.interactor = interactor
    }
}
