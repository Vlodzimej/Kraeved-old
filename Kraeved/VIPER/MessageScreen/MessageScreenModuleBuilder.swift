//
//  MessageScreenModuleBuilder.swift
//  Kraeved
//
//  Created by Владимир Амелькин on 05.01.2023.
//

import Foundation

final class MessageScreenModuleBuilder {
    static func build(messageText: String) -> MessageScreenViewController {
		let router = BaseRouter()
		let presenter = MessageScreenPresenter(router: router)
		let viewController = MessageScreenViewController(presenter: presenter, messageText: messageText)
		presenter.view = viewController
        router.viewController = viewController
		return viewController
	}
}
