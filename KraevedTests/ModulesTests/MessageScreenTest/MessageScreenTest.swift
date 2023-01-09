//
//  MessageScreenTest.swift
//  KraevedTests
//
//  Created by Владимир Амелькин on 09.01.2023.
//

import XCTest
@testable import Kraeved

final class MessageScreenTest: XCTestCase {
    
    var presenter: MessageScreenPresenter!
    var view: MessageScreenViewMock?
    var router: BaseRouterMock?

    override func setUpWithError() throws {
        view = MessageScreenViewMock()
        router = MainScreenRouterMock()
        guard let router = router else { return }

        presenter = MessageScreenPresenter(router: router)
        presenter.view = view
    }

    override func tearDownWithError() throws {
        presenter = nil
    }
    
    func testDismiss() {
        presenter.dismiss()
        XCTAssertTrue(router?.isDismissed ?? false)
    }
}

final class MessageScreenViewMock: MessageScreenViewProtocol {
    
}
