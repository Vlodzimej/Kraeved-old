//
//  StartScreenRouter.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 04.01.2023.
//

import Foundation

protocol StartScreenRouterProtocol: BaseRouterProtocol {
    func dismiss()
}

class StartScreenRouter: BaseRouter<StartScreenViewController>, StartScreenRouterProtocol {
    func dismiss() {
        viewController?.dismiss(animated: true)
    }
}
