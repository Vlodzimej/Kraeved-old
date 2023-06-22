//
//  FavoriteScreenInteractor.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 22.06.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

//MARK: - FavoriteScreenInteractorProtocol
protocol FavoriteScreenInteractorProtocol: AnyObject {
}

//MARK: - FavoriteScreenInteractor
class FavoriteScreenInteractor: FavoriteScreenInteractorProtocol {

    //MARK: Properties
    weak var presenter: FavoriteScreenPresenterProtocol?

    //MARK: Init
    init() {
    }

    //MARK: Private Methods

    //MARK: Public Methods
}
